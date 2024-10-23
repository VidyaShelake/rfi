// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UploadImage extends StatefulWidget {
//   const UploadImage({super.key});
//
//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }
//
// class _UploadImageState extends State<UploadImage> {
//   File? _image; // To hold the selected image
//
//   // Method to pick and upload an image from the gallery
//   Future<void> _uploadImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path); // Save the selected image file
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upload Image'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Display the selected image
//             _image != null
//                 ? Image.file(
//               _image!,
//               height: 200,
//               width: 200,
//               fit: BoxFit.cover,
//             )
//                 : const Text('No image selected.'),
//
//             const SizedBox(height: 20),
//
//             // Button to upload an image
//             ElevatedButton(
//               onPressed: _uploadImage,
//               child: const Text('Upload Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
