import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants/apiList.dart';
import 'loginPage.dart'; // Make sure this file exists

class Dashboarddrawer extends StatefulWidget {
  const Dashboarddrawer({Key? key}) : super(key: key);

  @override
  State<Dashboarddrawer> createState() => _DashboarddrawerState();
}

class _DashboarddrawerState extends State<Dashboarddrawer> {
  final Dio dio = Dio(); // Create a Dio instance
  var uploadData;
  var maker = 'Maker';
  var userId ='25';
  var rfiMaster;
  var rfiDetailsList;

  var token;
  int? _selectedClientId;
  String? _selectedClientName;
  int? _selectedProjectId;
  String? _selectedProjectName;
  int? _selectedWorkTypeId;
  String? _selectedWorkTypeName;
  int? _selectedStrutureId;
  String? _selectedStrutureName;
  int? _selectedStageId;
  String? _selectedStageName;
  int? _selectedUnitId;
  String? _selectedUnitName;
  int? _selectedSubUnitId;
  String? _selectedSubUnitName;
  int? _selectedCheckListId;
  String? _selectedCheckListName;
  int? _selectedGroupId;
  String? _selectedGroupName;
  String? _selectedCoverage;
  int? _selectedDrawingNo;
  int? _selectedQuestionId;
  String? _rfidetailAnswer;
  String? _rfidetailRemark;
  int?  node_user_mkr_repr_id ;

  get savedNodeUserDetail => null;

  @override
  void initState() {
    super.initState();
    _loadClientData();
  }
  Future<void> _loadClientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      _selectedClientId = _getIntFromPrefs(prefs, 'client_id');
      _selectedClientName = prefs.getString('client_name');
      _selectedProjectId = _getIntFromPrefs(prefs, 'project_id');
      _selectedProjectName = prefs.getString('project_name');
      _selectedWorkTypeId = _getIntFromPrefs(prefs, 'worktype_id');
      _selectedWorkTypeName = prefs.getString('worktype_name');
      _selectedStrutureId = _getIntFromPrefs(prefs, 'structure_id');
      _selectedStrutureName = prefs.getString('structure_name');
      _selectedStageId = _getIntFromPrefs(prefs, 'stage_id');
      _selectedStageName = prefs.getString('stage_name');
      _selectedUnitId = _getIntFromPrefs(prefs, 'unit_id');
      _selectedUnitName = prefs.getString('unit_name');
      _selectedSubUnitId = _getIntFromPrefs(prefs, 'subunit_id');
      _selectedSubUnitName = prefs.getString('subunit_name');
      _selectedCheckListId = _getIntFromPrefs(prefs, 'checklist_id');
      _selectedCheckListName = prefs.getString('checklist_name');
      _selectedGroupId = _getIntFromPrefs(prefs, 'group_id');
      _selectedGroupName = prefs.getString('group_name');
      _selectedCoverage = prefs.getString('coverage');
      _selectedDrawingNo = _getIntFromPrefs(prefs, 'drawing_number');
      _selectedQuestionId = _getIntFromPrefs(prefs, 'selectedQuestionId');
      _rfidetailAnswer = prefs.getString('rfidetailAnswer');
      _rfidetailRemark = prefs.getString('remark');
      token = prefs.getString('TOKEN');

      // Retrieving the data later
      String? savedNodeUserDetailString = prefs.getString('node_user_data');
      if (savedNodeUserDetailString != null) {
        Map<String, dynamic> savedNodeUserDetail = jsonDecode(savedNodeUserDetailString);
        print(savedNodeUserDetail); // This will print the decoded Map
      }
    });

  }

  int? _getIntFromPrefs(SharedPreferences prefs, String key) {
    final value = prefs.get(key);
    if (value is int) {
      return value;
    } else if (value is String) {
      // Try parsing the string to an integer
      return int.tryParse(value);
    }
    return null; // Return null if it's neither
  }


  void refreshData() {
    // Implement your refresh/clear logic here
    print('Data refreshed/cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 120,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Center(
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.upload,
                  color: Colors.teal,
                ),
                SizedBox(width: 5),
                const Text('Upload Data'),
              ],
            ),
            onTap: uploadData, // Call the uploadData function
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.image,
                  color: Colors.teal,
                ),
                SizedBox(width: 5),
                const Text('Upload Image'),
              ],
            ),
            // onTap: uploadImage, // Call the uploadImage function
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.refresh,
                  color: Colors.teal,
                ),
                SizedBox(width: 5),
                const Text('Refresh/Clear'),
              ],
            ),
            onTap: refreshData, // Call the refresh function
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.teal,
                ),
                SizedBox(width: 5),
                const Text('Log Out'),
              ],
            ),
            onTap: () async {
              // Clear all SharedPreferences data
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Clears all stored data
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
  postUploadDat() async {
    try {
      final postData = {
        rfiMaster: {
          'clientId': _selectedClientId,
          'projectId': _selectedProjectId,
          'rfiNodeId':_selectedUnitId,
          'rfiLevel': 3,
          'rfiActivity':_selectedWorkTypeId,
          // 'worktype_id': _selectedWorkTypeId,
          'structureId': _selectedStrutureId,
          'stageId': _selectedStageId,
          'unitId': _selectedUnitId,
          'subunitId': _selectedSubUnitId,
          'checklistId': _selectedCheckListId,
          'groupId': _selectedGroupId,
          'rfiCoverage': _selectedCoverage,
          'rfiDrawingNo': _selectedDrawingNo,
          'rfiStatus':1,
          'rfiMkrReprId':savedNodeUserDetail['node_user_mkr_repr_id'],
          'rfiMkrUserType':savedNodeUserDetail['node_user_mkr_user_type'],
          'rfiCheckerReprId':savedNodeUserDetail['node_user_checker3_user_type'],
          'rfiApproverReprId':savedNodeUserDetail['node_user_approver_repr_id'],
          'rfiApproverUserType':savedNodeUserDetail['node_user_approver_user_type'],
          'rfiCancelStatus':0,
          'contractorId':savedNodeUserDetail ['node_user_contractor_id'],


        },
        'rfiDetailsList': [
          {
            'questionId': _selectedQuestionId,
            'rfidetailEnterById':userId,
            'rfidetailRoundNo':1,
            'rfidetailAnswer': _rfidetailAnswer,
            'rfidetailRemark':_rfidetailRemark,
            'rfidetailFinalStatus':1,

          },
        ]
      };
      final response = await dio.post(Api.UploadRFI,// Replace with your actual POST endpoint
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: postData,
      );
      print(response);


      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {


        Fluttertoast.showToast(
          msg: "Data save successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Failed to Upload Data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

}
