import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/apiList.dart';
import '../constants/baseUrl.dart';

class Allocatedata2 extends StatefulWidget {
  const Allocatedata2({super.key});

  @override
  State<Allocatedata2> createState() => _Allocatedata2State();
}

class _Allocatedata2State extends State<Allocatedata2> {
  String? _selectedClient; // Selected client ID
  String? _selectedProject; // Selected client ID
  String? _selectedWorkType; // Selected client ID
  String? _selectedStructure; // Selected client ID
  String? _selectedStage; // Selected client ID
  String? _selectedUnit; // Selected client ID
  String? _selectedSubUnit; // Selected client ID
  String? _selectedCheckList; // Selected client ID
  String? _selectedGroupList; // Selected client ID

  var sharedPreferences;
  var token;
  var tokentype;
  int? clientId;
  var userIdd = 25;

  final Dio dio = Dio(); // Create a Dio instance
  List<Map<String, dynamic>> clientList = [];
  List<Map<String, dynamic>> projectList = [];
  List<Map<String, dynamic>> workTypeList = [];
  List<Map<String, dynamic>> structureList = [];
  List<Map<String, dynamic>> stageList = [];
  List<Map<String, dynamic>> unitList = [];
  List<Map<String, dynamic>> subUnitList = [];
  List<Map<String, dynamic>> checkList = [];
  List<Map<String, dynamic>> groupList = [];

  @override
  void initState() {
    super.initState();
    getData();
    // loadClientListFromSharedPreferences();
  }

  getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(Constants.TOKEN) ?? "";
    tokentype = sharedPreferences.getString(Constants.TOKENTYPE) ?? "";

    print(token);

    setState(() {
      token;
      tokentype;
    });
    getClientDropdown();
  }

  // void loadClientListFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? clientListJson = prefs.getString('clientList');
  //   if (clientListJson != null) {
  //     List<dynamic> storedClientList = jsonDecode(clientListJson);
  //
  //     setState(() {
  //       clientList = storedClientList.map((item) => {
  //         'cl_id': item['cl_id'],
  //         'cl_name': item['cl_name'],
  //       }).toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Allocate Data',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Client ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedClient,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedClient = newValue;
                        });
                        getProjectDropdown(); // Fetch projects after selecting a client
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14), // Add spacing between dropdowns
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Project ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedProject,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedProject = newValue;
                        });
                        getWorkTypeDropdown();
                      },
                      items: projectList
                          .map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['prj_id'].toString(),
                          child: Text(value['prj_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14), // Add spacing between dropdowns
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Work Type ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedWorkType,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedWorkType = newValue;
                        });
                        getStructureDropdown();
                      },
                      items: workTypeList
                          .map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['activity_sequence_groupid'].toString(),
                          child:
                              Text(value['activity_sequence_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14), // Add spacing between dropdowns
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Structure ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedStructure,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedStructure = newValue;
                        });
                        getStageDropdown();
                      },
                      items: structureList
                          .map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['structureId'].toString(),
                          child: Text(value['structureName'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14), // Add spacing between dropdowns
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Stage ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedStage,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedStage = newValue;
                        });
                        getUnitDropdown();
                      },
                      items:
                          stageList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['stageId'].toString(),
                          child: Text(value['stageName'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14), // Add spacing between dropdowns
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Unit ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedUnit,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedUnit = newValue;
                        });
                        getSubUnitDropdown();
                      },
                      items:
                          unitList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['unitId'].toString(),
                          child: Text(value['unitName'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select SubUnit ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedSubUnit,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSubUnit = newValue;
                        });
                        getCheckListDropdown();
                      },
                      items: subUnitList
                          .map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['subUnitId'].toString(),
                          child: Text(value['subUnitName'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select CheckList ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedCheckList,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCheckList = newValue;
                        });
                        getGroupListDropdown();
                      },
                      items:
                          checkList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['chklId'].toString(),
                          child: Text(value['chklName'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 14,
                          // color: ColorConstants.textlightgrey,
                          fontWeight: FontWeight.w400,
                        ),
                        label: const Text(
                          "Select Group ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: ColorConstants.textlightgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // color: ColorConstants.bordergrey,
                              ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // dropdownColor: ColorConstants.white,
                      value: _selectedGroupList,
                      icon: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGroupList = newValue;
                        });
                      },
                      items:
                          groupList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['groupId'].toString(),
                          child: Text(value['groupName'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

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
                // Debug: Print selected client, project, work type, structure, stage, unit, subunit, checklist, and group details
                print('Selected Client: $_selectedClient');
                print('Client List: $clientList');
                print('Selected Project: $_selectedProject');
                print('Project List: $projectList');
                print('Selected WorkType: $_selectedWorkType');
                print('WorkType List: $workTypeList');
                print('Selected Structure: $_selectedStructure');
                print('Structure List: $structureList');
                print('Selected Stage: $_selectedStage');
                print('Stage List: $stageList');
                print('Selected Unit: $_selectedUnit');
                print('Unit List: $unitList');
                print('Selected Subunit: $_selectedSubUnit');
                print('Subunit List: $subUnitList');
                print('Selected Checklist: $_selectedCheckList');
                print('Checklist List: $checkList');
                print('Selected Group: $_selectedGroupList'); // Add group print
                print('Group List: $groupList'); // Add group list print

                // Parse selected client, project, work type, structure, stage, unit, subunit, checklist, and group as int
                var selectedClientId = int.tryParse(_selectedClient!);
                var selectedProjectId = int.tryParse(_selectedProject!);
                var selectedWorkTypeId = int.tryParse(_selectedWorkType!);
                var selectedStructureId = int.tryParse(_selectedStructure!);
                var selectedStageId = int.tryParse(_selectedStage!);
                var selectedUnitId = int.tryParse(_selectedUnit!);
                var selectedSubunitId = int.tryParse(_selectedSubUnit!);
                var selectedChecklistId = int.tryParse(_selectedCheckList!);
                var selectedGroupId = int.tryParse(_selectedGroupList!); // Parse group ID

                // Validate parsed values
                if (selectedClientId == null) {
                  print('Error: _selectedClient is not a valid integer.');
                  return;
                }
                if (selectedProjectId == null) {
                  print('Error: _selectedProject is not a valid integer.');
                  return;
                }
                if (selectedWorkTypeId == null) {
                  print('Error: _selectedWorkType is not a valid integer.');
                  return;
                }
                if (selectedStructureId == null) {
                  print('Error: _selectedStructure is not a valid integer.');
                  return;
                }
                if (selectedStageId == null) {
                  print('Error: _selectedStage is not a valid integer.');
                  return;
                }
                if (selectedUnitId == null) {
                  print('Error: _selectedUnit is not a valid integer.');
                  return;
                }
                if (selectedSubunitId == null) {
                  print('Error: _selectedSubunit is not a valid integer.');
                  return;
                }
                if (selectedChecklistId == null) {
                  print('Error: _selectedChecklist is not a valid integer.');
                  return;
                }
                if (selectedGroupId == null) { // Validate group ID
                  print('Error: _selectedGroup is not a valid integer.');
                  return;
                }

                // Find the client, project, work type, structure, stage, unit, subunit, checklist, and group safely
                try {
                  var selectedClient = clientList.firstWhere(
                        (client) => client['cl_id'] == selectedClientId,
                    orElse: () => {},
                  );
                  if (selectedClient.isEmpty) {
                    print('Error: No client found with the selected ID.');
                    return;
                  }
                  var clientName = selectedClient['cl_name'].toString();

                  var selectedProject = projectList.firstWhere(
                        (project) => project['prj_id'] == selectedProjectId,
                    orElse: () => {},
                  );
                  if (selectedProject.isEmpty) {
                    print('Error: No project found with the selected ID.');
                    return;
                  }
                  var projectName = selectedProject['prj_name'].toString();

                  var selectedWorkType = workTypeList.firstWhere(
                        (workType) => workType['activity_sequence_groupid'] == selectedWorkTypeId,
                    orElse: () => {},
                  );
                  if (selectedWorkType.isEmpty) {
                    print('Error: No work type found with the selected ID.');
                    return;
                  }
                  var workTypeName = selectedWorkType['activity_sequence_name'].toString();

                  var selectedStructure = structureList.firstWhere(
                        (structure) => structure['structureId'] == selectedStructureId,
                    orElse: () => {},
                  );
                  if (selectedStructure.isEmpty) {
                    print('Error: No structure found with the selected ID.');
                    return;
                  }
                  var structureName = selectedStructure['structureName'].toString();

                  var selectedStage = stageList.firstWhere(
                        (stage) => stage['stageId'] == selectedStageId,
                    orElse: () => {},
                  );
                  if (selectedStage.isEmpty) {
                    print('Error: No stage found with the selected ID.');
                    return;
                  }
                  var stageName = selectedStage['stageName'].toString();

                  var selectedUnit = unitList.firstWhere(
                        (unit) => unit['unitId'] == selectedUnitId,
                    orElse: () => {},
                  );
                  if (selectedUnit.isEmpty) {
                    print('Error: No unit found with the selected ID.');
                    return;
                  }
                  var unitName = selectedUnit['unitName'].toString();

                  var selectedSubunit = subUnitList.firstWhere(
                        (subunit) => subunit['subUnitId'] == selectedSubunitId,
                    orElse: () => {},
                  );
                  if (selectedSubunit.isEmpty) {
                    print('Error: No subunit found with the selected ID.');
                    return;
                  }
                  var subunitName = selectedSubunit['subUnitName'].toString();

                  var selectedChecklist = checkList.firstWhere(
                        (checklist) => checklist['chklId'] == selectedChecklistId,
                    orElse: () => {},
                  );
                  if (selectedChecklist.isEmpty) {
                    print('Error: No checklist found with the selected ID.');
                    return;
                  }
                  var checklistName = selectedChecklist['chklName'].toString();

                  var selectedGroup = groupList.firstWhere(
                        (group) => group['groupId'] == selectedGroupId,
                    orElse: () => {},
                  );
                  if (selectedGroup.isEmpty) {
                    print('Error: No group found with the selected ID.');
                    return;
                  }
                  var groupName = selectedGroup['groupName'].toString(); // Assuming you have a group name field

                  // Save client, project, work type, structure, stage, unit, subunit, checklist, and group details in SharedPreferences
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('client_id', selectedClientId);
                  await prefs.setString('client_name', clientName);
                  await prefs.setInt('project_id', selectedProjectId);
                  await prefs.setString('project_name', projectName);
                  await prefs.setInt('worktype_id', selectedWorkTypeId);
                  await prefs.setString('worktype_name', workTypeName);
                  await prefs.setInt('structure_id', selectedStructureId);
                  await prefs.setString('structure_name', structureName);
                  await prefs.setInt('stage_id', selectedStageId);
                  await prefs.setString('stage_name', stageName);
                  await prefs.setInt('unit_id', selectedUnitId);
                  await prefs.setString('unit_name', unitName);
                  await prefs.setInt('subunit_id', selectedSubunitId);
                  await prefs.setString('subunit_name', subunitName);
                  await prefs.setInt('checklist_id', selectedChecklistId); // Save checklist ID
                  await prefs.setString('checklist_name', checklistName); // Save checklist name
                  await prefs.setInt('group_id', selectedGroupId); // Save group ID
                  await prefs.setString('group_name', groupName); // Save group name

                  // Debug: Confirm saving
                  print('Group ID Saved: $selectedGroupId'); // Confirm group ID saved
                  print('Group Name Saved: $groupName'); // Confirm group name saved
                } catch (e) {
                  print('Error: $e');
                }

                // Close the dialog if context is still mounted
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
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
            ),
                        ],
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }

  void getClientDropdown() async {
    try {
      final response = await dio.get(
        Api.ClientMaker + '25' + '/' + 'Maker',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        clientList.clear();
        for (var item in response.data) {
          clientList.add({
            'cl_id': item['cl_id'],
            'cl_name': item['cl_name'],
          });
        }
        // Store the clientList in SharedPreferences
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // String clientListJson = jsonEncode(clientList);
        // await prefs.setString('clientList', clientListJson);
        setState(() {
          clientList;
        });
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getProjectDropdown() async {
    try {
      final response = await dio.get(
        Api.ProjectMaker + '25' + '/' + 'Maker',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        projectList.clear();

        // Extracting only project data for dropdown
        for (var item in response.data) {
          var project = item['project'];
          projectList.add({
            'prj_id': project['prj_id'],
            'prj_name': project['prj_name'],
          });
        }

// Assuming you are in an async function
        var nodeUserDetail = response.data[0]['node_user_detail'];
        print(nodeUserDetail);

        // Convert the JSON object to a string
        String nodeUserDetailString = jsonEncode(nodeUserDetail);

// Save the string in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('node_user_data', nodeUserDetailString);


        // Saving individual node_user_detail values to SharedPreferences
        //       var nodeUserDetail = response.data[0]['node_user_detail'];
        //       print(nodeUserDetail);
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('node_user_data', nodeUserDetail);
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // await prefs.setInt('node_user_checker_user_type', nodeUserDetail['node_user_checker_user_type']);
              // await prefs.setInt('node_user_approver_user_type', nodeUserDetail['node_user_approver_user_type']);
              // await prefs.setInt('node_user_checker2_repr_id', nodeUserDetail['node_user_checker2_repr_id'] ?? 0);
              // await prefs.setInt('node_user_mkr_repr_id', nodeUserDetail['node_user_mkr_repr_id']);
              // await prefs.setInt('node_user_mkr_user_type', nodeUserDetail['node_user_mkr_user_type']);
              // await prefs.setInt('node_user_contractor_id', nodeUserDetail['node_user_contractor_id']);
              // await prefs.setInt('node_user_checker_repr_id', nodeUserDetail['node_user_checker_repr_id']);
              // await prefs.setInt('node_user_approver_repr_id', nodeUserDetail['node_user_approver_repr_id']);


        setState(() {
          projectList;
        });
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getWorkTypeDropdown() async {
    try {
      final response = await dio.get(
        Api.WorkTypeMaker + '25' + '/' + 'Maker',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        workTypeList.clear();
        for (var item in response.data) {
          workTypeList.add({
            'activity_sequence_groupid': item['activity_sequence_groupid'],
            'activity_sequence_name': item['activity_sequence_name'],
          });
        }
        setState(() {
          workTypeList;
        });
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getStructureDropdown() async {
    try {
      final response = await dio.get(
        Api.structureMaker +
            '25' +
            '/' +
            'Maker' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedWorkType.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response);
        structureList.clear();
        for (var item in response.data) {
          structureList.add({
            'structureId': item['structureId'],
            'structureName': item['structureName'],
          });
        }
        setState(() {
          structureList;
        });
      } else {
        print("error");
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getStageDropdown() async {
    try {
      final response = await dio.get(
        Api.stageMaker +
            '25' +
            '/' +
            'Maker' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedWorkType.toString() +
            '/' +
            _selectedStructure.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response);
        stageList.clear();
        for (var item in response.data) {
          stageList.add({
            'stageId': item['stageId'],
            'stageName': item['stageName'],
          });
        }
        setState(() {
          stageList;
        });
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getUnitDropdown() async {
    try {
      final response = await dio.get(
        Api.UnitMaker +
            '25' +
            '/' +
            'Maker' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedWorkType.toString() +
            '/' +
            _selectedStage.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response);
        unitList.clear();
        for (var item in response.data) {
          unitList.add({
            'unitId': item['unitId'],
            'unitName': item['unitName'],
          });
        }
        setState(() {
          unitList;
        });
      } else {
        print("error");
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getSubUnitDropdown() async {
    try {
      final response = await dio.get(
        Api.SubUnitMaker +
            '25' +
            '/' +
            'Maker' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedWorkType.toString() +
            '/' +
            _selectedUnit.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response);
        subUnitList.clear();
        for (var item in response.data) {
          subUnitList.add({
            'subUnitId': item['subUnitId'],
            'subUnitName': item['subUnitName'],
          });
        }
        setState(() {
          subUnitList;
        });
      } else {
        print("error");
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getCheckListDropdown() async {
    try {
      final response = await dio.get(
        Api.CheckList +
            '25' +
            '/' +
            'Maker' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedWorkType.toString() +
            '/' +
            _selectedUnit.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response);
        checkList.clear();
        for (var item in response.data) {
          checkList.add({
            'chklId': item['chklId'],
            'chklName': item['chklName'],
          });
        }
        setState(() {
          checkList;
        });
      } else {
        print("error");
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

  void getGroupListDropdown() async {
    try {
      final response = await dio.get(
        Api.GroupList +
            '25' +
            '/' +
            'Maker' +
            '/' +
            _selectedClient.toString() +
            '/' +
            _selectedProject.toString() +
            '/' +
            _selectedCheckList.toString() +
            '/' +
            _selectedUnit.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response);
        groupList.clear();
        for (var item in response.data) {
          groupList.add({
            'groupId': item['groupId'],
            'groupName': item['groupName'],
          });
        }
        setState(() {
          groupList;
        });
      } else {
        print("error");
      }
    } on DioError catch (e) {
      // Handle error
      print(e.response);
    }
  }

}
