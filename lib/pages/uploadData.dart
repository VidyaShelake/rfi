import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/apiList.dart';
class Uploaddata extends StatefulWidget {
  const Uploaddata({super.key});

  @override
  State<Uploaddata> createState() => _UploaddataState();
}

class _UploaddataState extends State<Uploaddata> {
  final Dio dio = Dio(); // Create a Dio instance
  var uploadData;
  var maker = 'Maker';
  var userId ='25';
  var rfiMaster;
  var rfiDetailsList;


  String? _selectedClientId;
  String? _selectedClientName;
  String? _selectedProjectId;
  String? _selectedProjectName;
  String? _selectedWorkTypeId;
  String? _selectedWorkTypeName;
  String? _selectedStrutureId;
  String? _selectedStrutureName;
  String? _selectedStageId;
  String? _selectedStageName;
  String? _selectedUnitId;
  String? _selectedUnitName;
  String? _selectedSubUnitId;
  String? _selectedSubUnitName;
  String? _selectedCheckListId;
  String? _selectedCheckListName;
  String? _selectedGroupId;
  String? _selectedGroupName;
  String? _selectedCoverage;
  String? _selectedDrawingNo;
  String? _selectedQuestionId;
  String? _rfidetailAnswer;
  String? _rfidetailRemark;

  @override
  void initState() {
    super.initState();
    _loadClientData();
  }
  Future<void> _loadClientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedClientId = prefs.getInt('client_id')?.toString();
      _selectedClientName = prefs.getString('client_name');
      _selectedProjectId = prefs.getInt('project_id')?.toString();
      _selectedProjectName = prefs.getString('project_name');
      _selectedWorkTypeId = prefs.getInt('worktype_id')?.toString();
      _selectedWorkTypeName = prefs.getString('worktype_name');
      _selectedStrutureId = prefs.getInt('structure_id')?.toString();
      _selectedStrutureName = prefs.getString('structure_name');
      _selectedStageId = prefs.getInt('stage_id')?.toString();
      _selectedStageName = prefs.getString('stage_name');
      _selectedUnitId = prefs.getInt('unit_id')?.toString();
      _selectedUnitName = prefs.getString('unit_name');
      _selectedSubUnitId = prefs.getInt('subunit_id')?.toString();
      _selectedSubUnitName = prefs.getString('subunit_name');
      _selectedCheckListId = prefs.getInt('checklist_id')?.toString();
      _selectedCheckListName = prefs.getString('checklist_name');
      _selectedGroupId = prefs.getInt('group_id')?.toString();
      _selectedGroupName = prefs.getString('group_name');
      _selectedCoverage = prefs.getString('coverage');
      _selectedDrawingNo = prefs.getInt('drawing_number')?.toString();
      _selectedQuestionId =prefs.getString('selectedQuestionId');
      _rfidetailAnswer =prefs.getString('rfidetailAnswer');
      _rfidetailRemark =prefs.getString('remark');
      // // Retrieving the data later
      // String? savedNodeUserDetailString = prefs.getString('node_user_data');
      // if (savedNodeUserDetailString != null) {
      //   Map<String, dynamic> savedNodeUserDetail = jsonDecode(savedNodeUserDetailString);
      //   print(savedNodeUserDetail); // This will print the decoded Map
      // }
    });
  }

  void refreshData() {
    // Implement your refresh/clear logic here
    print('Data refreshed/cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

        },
        'rfiDetailsList': [
          {
            'questionId': _selectedQuestionId,
            'rfidetailAnswer': _rfidetailAnswer,
            'rfidetailRemark':_rfidetailRemark,
            'rfidetailEnterById':userId,
            'rfidetailRoundNo':1,

          },
        ]
      };



      final response = await dio.post(Api.UploadRFI,// Replace with your actual POST endpoint
        data: postData,
      );

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
