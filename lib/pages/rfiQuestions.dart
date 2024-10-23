import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rfi/pages/dashboard.dart';
import 'package:rfi/pages/rfiDemoService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For jsonDecode
import '../constants/apiList.dart';
import '../constants/baseUrl.dart';
import 'colors.dart';

class Rfiquestions extends StatefulWidget {
  const Rfiquestions({super.key});

  @override
  State<Rfiquestions> createState() => _RfiquestionsState();
}

class _RfiquestionsState extends State<Rfiquestions> {
  final Dio dio = Dio(); // Create a Dio instance
  List<Map<String, dynamic>> questionList = [];

  var token;
  int? _selectedClient;
  int? _selectedProject;
  int? _selectedGroup;
  int? _selectedUnit;
  int? _selectedQuestionId; // Store selected questionId

  @override
  void initState() {
    super.initState();
    _loadLocalStorage(); // Load local storage values
  }

  void _loadLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(Constants.TOKEN) ?? "";
    _selectedClient = prefs.getInt('client_id');
    _selectedProject = prefs.getInt('project_id');
    _selectedGroup = prefs.getInt('group_id');
    _selectedUnit = prefs.getInt('unit_id');
    _selectedQuestionId = prefs.getInt('selectedQuestionId'); // Retrieve selectedQuestionId

    getRfiQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RfiQuestions',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // await prefs.remove('selectedQuestionId'); // Clear the stored questionId
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: questionList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = questionList[index];
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setInt('selectedQuestionId', item['questionRfiId']);
                      await prefs.setString('selectedQuestionDescription', item['description']);

                      // Navigate to the next page on tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Rfidemoservice(
                            description: item['description'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: _getCardColor(item['questionRfiId']), // Color based on questionId
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['description'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(width: 30),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add two OutlineButton widgets below the ListView
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.25,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getRfiQuestions() async {
    try {
      final response = await dio.get(
        Api.QuestionRFI +
            '25' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedGroup.toString() +
            '/' +
            _selectedUnit.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        questionList.clear();
        for (var item in response.data) {
          questionList.add({
            'questionRfiId': item['questionRfiId'],
            'description': item['description'],
            'questionType': item['questionType'],
          });
        }
        setState(() {
          questionList;
        });
      } else {
        print("error");
      }
    } on DioError catch (e) {
      print(e.response);
    }
  }

  // Function to get color based on questionId
  Color _getCardColor(int questionId) {
    if (_selectedQuestionId == questionId) {
      return Colors.blueAccent; // Color for selected question
    } else {
      return Colors.white; // Default color for unselected questions
    }
  }
}
