import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'; // For basename function
import 'package:mime/mime.dart'; // For MIME type detection
import 'package:http_parser/http_parser.dart';
import 'package:rfi/constants/apiList.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/baseUrl.dart'; // For multipart

class CaptureImage extends StatefulWidget {
  const CaptureImage({super.key});

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  File? _image1; // To hold the first captured image
  File? _image2; // To hold the second captured image
  final Dio dio = Dio(); // Create a Dio instance
  int? _selectedQuestionId;

  var token;
  // To keep track of which image to capture or upload
  int _currentImageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadClientData();
  }

  Future<void> _loadClientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedQuestionId = prefs.getInt('selectedQuestionId');
      token = prefs.getString(Constants.TOKEN) ?? "";
    });
  }

  void refreshData() {
    // Implement your refresh/clear logic here
    print('Data refreshed/cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture & Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image1 != null
                ? Image.file(_image1!, height: 150)
                : const Text('No first image selected.'),
            const SizedBox(height: 20),
            _image2 != null
                ? Image.file(_image2!, height: 150)
                : const Text('No second image selected.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showCaptureDialog(context),
              child: Text(_currentImageIndex == 1
                  ? 'Capture First Image'
                  : 'Capture Second Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImages, // Trigger the image upload on button click
              child: const Text('Upload Images to Server'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCaptureDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Capture & Upload'),
          content: const Text('Would you like to capture a photo or upload it?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _captureImage(); // Capture image
                Navigator.of(context).pop();
              },
              child: const Text('Capture'),
            ),
            TextButton(
              onPressed: () {
                _uploadImage(); // Upload image from gallery
                Navigator.of(context).pop();
              },
              child: const Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (_currentImageIndex == 1) {
          _image1 = File(pickedFile.path);
          _currentImageIndex = 2; // Switch to the second image
        } else if (_currentImageIndex == 2) {
          _image2 = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (_currentImageIndex == 1) {
          _image1 = File(pickedFile.path);
          _currentImageIndex = 2; // Switch to the second image
        } else if (_currentImageIndex == 2) {
          _image2 = File(pickedFile.path);
        }
      });
    }
  }
  Future<void> _uploadImages() async {
    try {
      // Upload both images concurrently (if both exist)
      List<Future> uploadTasks = [];

      if (_image1 != null) {
        uploadTasks.add(_uploadImageToServer(_image1!));
      }
      if (_image2 != null) {
        uploadTasks.add(_uploadImageToServer(_image2!));
      }

      if (uploadTasks.isNotEmpty) {
        await Future.wait(uploadTasks); // Execute uploads concurrently
        Fluttertoast.showToast(msg: "Both images uploaded successfully!");
      } else {
        Fluttertoast.showToast(msg: "No images to upload.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error during upload: $e");
    }
  }

  Future<void> _uploadImageToServer(File imageFile) async {
    try {
      // Retrieve the token once
      final token = await getTokenFromSharedPreferences();

      // Create FormData for image upload
      final mimeTypeData = lookupMimeType(imageFile.path)?.split('/');
      if (mimeTypeData == null) {
        Fluttertoast.showToast(msg: "Unable to determine file type.");
        return;
      }

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: basename(imageFile.path),
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      });

      // Perform the API call
      final response = await dio.put(
        "${Api.UploadImage}/$_selectedQuestionId",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Send the token with each request
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Handle API response
      if (response.statusCode == 200) {
        final responseData = response.data;
        final imagePath1 = responseData['rfidetailImagePath1'];
        final imagePath2 = responseData['rfidetailImagePath2'];

        Fluttertoast.showToast(
          msg: "Image uploaded successfully! Path1: $imagePath1, Path2: $imagePath2",
        );
      } else {
        Fluttertoast.showToast(msg: "Image upload failed! Status: ${response.statusCode}");
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: "Error uploading image: ${e.response?.data ?? e.message}",
      );
    }
  }

// Optimized token retrieval
  Future<String> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ?? ''; // Ensure 'auth_token' is properly stored
  }
}
