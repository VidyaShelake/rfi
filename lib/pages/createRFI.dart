import 'package:flutter/material.dart';
import 'package:rfi/pages/rfiQuestions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

class Createrfi extends StatefulWidget {
  const Createrfi({super.key});

  @override
  State<Createrfi> createState() => _CreaterfiState();
}

class _CreaterfiState extends State<Createrfi> {
  String? _selectedClient; // Selected client ID
  List<Map<String, dynamic>> clientList = [];
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

  final TextEditingController edit1client = TextEditingController();
  final TextEditingController edit2project = TextEditingController();
  final TextEditingController edit3WorkType = TextEditingController();
  final TextEditingController edit4structure = TextEditingController();
  final TextEditingController edit5stage = TextEditingController();
  final TextEditingController edit6unit = TextEditingController();
  final TextEditingController edit7subunit = TextEditingController();
  final TextEditingController edit8checkList = TextEditingController();
  final TextEditingController edit10group = TextEditingController();
  final TextEditingController edit9drawingNo = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadClientData();
    // Set focus on the TextFormField
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
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

      edit1client.text = _selectedClientName ?? '';
      edit2project.text = _selectedProjectName ?? '';
      edit3WorkType.text = _selectedWorkTypeName ?? '';
      edit4structure.text = _selectedStrutureName ?? '';
      edit5stage.text = _selectedStageName ?? '';
      edit6unit.text = _selectedUnitName ?? '';
      edit7subunit.text = _selectedSubUnitName ?? '';
      edit8checkList.text = _selectedCheckListName ?? '';
      edit10group.text = _selectedGroupName ?? '';
    });
  }

  @override
  void dispose() {
    edit1client.dispose();
    edit2project.dispose();
    edit3WorkType.dispose();
    edit4structure.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String? _selectedItem; // Initial dropdown value
  final List<Map<String, dynamic>> _dropdownItems = [
    {'id': '1', 'value': 'pp', 'label': 'pp'},
    {'id': '2', 'value': 'ss', 'label': 'ss'},
    {'id': '3', 'value': 'ee', 'label': 'ee'},
    {'id': '4', 'value': 'aa', 'label': 'aa'},
    {'id': '5', 'value': 'zz', 'label': 'zz'},
    {'id': '6', 'value': 'hh', 'label': 'hh'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            'Create RFI',
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
                    TextFormField(
                      readOnly: true,
                      controller:
                          edit1client, // Controller will now have the selected value
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Client',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit2project,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Project',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedProjectName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit3WorkType,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Work Type',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedProjectName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit4structure,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Structure',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedStrutureName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit5stage,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Stage',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedStageName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit6unit,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Unit',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedUnitName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit7subunit,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'SubUnit',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedSubUnitName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit8checkList,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'CheckList',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedCheckListName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: edit10group,
                      focusNode: _focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Group',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: _selectedGroupName ?? '',
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Add';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'Coverage',
                        labelStyle: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 11, 0, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      dropdownColor: Colors.white,
                      value: _selectedItem,
                      icon: Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.keyboard_arrow_down)),
                      iconSize: 35,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      validator: (value) => value == null ? '' : null,
                      items: [
                        DropdownMenuItem<String>(
                          value: '',
                          child: Text('Select an option'),
                        ),
                        ..._dropdownItems.map<DropdownMenuItem<String>>(
                            (Map<String, dynamic> item) {
                          return DropdownMenuItem<String>(
                            value: item['value'],
                            child: Text(item['label']),
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: edit9drawingNo,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number, // Set keyboard type to number
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        labelText: 'Drawing No',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        // Check if the value is null or empty
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Drawing No';
                        }
                        // Check if the value is a valid integer
                        final intValue = int.tryParse(value);
                        if (intValue == null) {
                          return 'Please enter a valid integer';
                        }
                        return null; // Return null if validation passes
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                              // Replace these with actual values for coverage and drawing number
                              String coverage =
                                  "your_coverage_value"; // get this value from your input
                              String drawingNumber = edit9drawingNo.text;

                              // Save coverage and drawing number in SharedPreferences
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('coverage', coverage);
                              await prefs.setString('drawing_number', drawingNumber);

                              // Navigate to the RFI questions screen
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Rfiquestions()),
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
            )));
  }
}
