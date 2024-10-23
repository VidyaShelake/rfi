import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rfi/pages/captureImage.dart';
import 'package:rfi/pages/rfiQuestions.dart';

class Rfidemoservice extends StatefulWidget {
  final String description;

  const Rfidemoservice({super.key, required this.description});

  @override
  State<Rfidemoservice> createState() => _RfidemoserviceState();
}

class _RfidemoserviceState extends State<Rfidemoservice> {
  final TextEditingController edit1Remark = TextEditingController();
  int? selectedValue;
  String displayText = '';
  int? _selectedQuestionId;

  @override
  void initState() {
    super.initState();
    _loadLocalStorage();
  }

  void _loadLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedQuestionId = prefs.getInt('selectedQuestionId');
    _loadRfiDetail();
  }

  void _saveData() async {
    if (selectedValue != null) {
      String remark = edit1Remark.text;

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Save selected value and remark to SharedPreferences
        await prefs.setInt('questionType', selectedValue!);
        await prefs.setString('remark', remark);
        await prefs.setString('rfidetailAnswer', displayText);

        // Create an RfiDetail object and serialize it to JSON
        RfiDetail rfiDetail = RfiDetail(
          questionId: _selectedQuestionId,
          questionType: selectedValue!,
          remark: remark,
        );
        String rfiDetailJson = jsonEncode(rfiDetail.toJson());

        // Save the serialized object in SharedPreferences
        await prefs.setString('rfiDetail', rfiDetailJson);

        // Navigate to RfiQuestions page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Rfiquestions()),
        );
      } catch (e) {
        // Handle any potential errors during the save operation, if necessary
        print('Error saving data: $e');
      }
    } else {
      // Show only the "Please select a question type" message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a question type')),
      );
    }
  }

  void _loadRfiDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rfiDetailJson = prefs.getString('rfiDetail');

    if (rfiDetailJson != null) {
      // Deserialize the JSON string to an RfiDetail object
      Map<String, dynamic> rfiDetailMap = jsonDecode(rfiDetailJson);
      RfiDetail rfiDetail = RfiDetail.fromJson(rfiDetailMap);

      setState(() {
        selectedValue = rfiDetail.questionType;
        edit1Remark.text = rfiDetail.remark;
        displayText = rfiDetail.questionType == 1
            ? 'Conformity'
            : rfiDetail.questionType == 2
            ? 'Non Conformity'
            : 'N/A';
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    var ds = widget.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'RFIDemoService',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ds,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              displayText = 'Conformity';
                            });
                          },
                        ),
                        const Text(
                          'Conformity',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              displayText = 'Non Conformity';
                            });
                          },
                        ),
                        const Text(
                          'Non Conformity',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<int>(
                          value: 3,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              displayText = 'N/A';
                            });
                          },
                        ),
                        const Text(
                          'N/A',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      displayText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: edit1Remark,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        isDense: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Remark',
                        labelStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black38),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid remark';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CaptureImage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Capture Images",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _saveData();
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RfiDetail {
  final int? questionId;
  final int questionType;
  final String remark;

  RfiDetail({
    this.questionId,
    required this.questionType,
    required this.remark,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionType': questionType,
      'remark': remark,
    };
  }

  // Convert from JSON
  factory RfiDetail.fromJson(Map<String, dynamic> json) {
    return RfiDetail(
      questionId: json['questionId'],
      questionType: json['questionType'],
      remark: json['remark'],
    );
  }
}
