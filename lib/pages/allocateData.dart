
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rfi/constants/apiList.dart';
import 'package:rfi/constants/baseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllocateData extends StatefulWidget {
  const AllocateData({super.key});
   static var ClientId;

  @override
  State<AllocateData> createState() => _AllocateDataState();
}
class _AllocateDataState extends State<AllocateData> {
  String? _selectedClient; // Selected client ID
  String? _selectedProject; // Selected project ID
  String? _selectedStructure; // Selected structure ID
  String? _selectedStage; // Selected stage ID
  String? _selectedUnit; // Selected stage ID
  String? _selectedSubUnit; // Selected stage ID
  String? _selectedCheckList; // Selected stage ID
  String? _selectedGroupList; // Selected stage ID

  var sharedPreferences;
  final Dio dio = Dio(); // Create a Dio instance

  var token;
  String? tokentype;
  var userId;
  var clientId;
  var projectId;

  // final String token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYW5kZWVwIiwiaWF0IjoxNzI0ODM4MTAzLCJleHAiOjE3MjQ5MjQ1MDN9.rjd3HeKGap0YL7hZynMyqoZ-6Ui9s6sCU2qdmBnl2Fy_XYMGIvw2quUq5QU90aUuC-XKrvM7RK_1XgJg1b_VZw'; // Replace with your actual token
  List<Map<String, dynamic>> clientList = [];
  List<Map<String, dynamic>> projectList = [];
  List<Map<String, dynamic>> structureList = [];
  List<Map<String, dynamic>> stageList = [];
  List<Map<String, dynamic>> unitList = [];
  List<Map<String, dynamic>> subUnitList = [];
  List<Map<String, dynamic>> checkList = [];
  List<Map<String, dynamic>> groupList = [];
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();

    getData();
    // Fetch data for the client dropdown
  }

  getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(Constants.TOKEN) ?? "";
    tokentype = sharedPreferences.getString(Constants.TOKENTYPE) ?? "";
    print(token);
    print(tokentype);

    setState(() {
      token;
      tokentype;
    });
    getClientDropdown();
    getProjectDropdown(userId);


  }

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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // isLoading
                //     ? const CircularProgressIndicator() // Show loading indicator while data is loading
                     DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select Client',
                    labelStyle: const TextStyle(
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
                  value: _selectedClient,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedClient = newValue;
                      _selectedProject = null; // Reset project and other dropdowns
                      AllocateData.ClientId =_selectedClient;

                      getProjectDropdown(newValue);
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: clientList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['cl_id'].toString(),
                      child: Text(value['cl_name'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedClient == null
                    ? const SizedBox.shrink() // Hide if no client selected
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select Project',
                    labelStyle: const TextStyle(
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
                  value: _selectedProject,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedProject = newValue;
                      _selectedStructure = null;
                      _selectedStage = null;
                    });
                    getStrutureDropdown(newValue);
                    getCheckListDropdown(newValue);

                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: projectList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['prj_id'].toString(),
                      child: Text(value['prj_name'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedProject == null
                    ? const SizedBox.shrink()
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select Structure',
                    labelStyle: const TextStyle(
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
                  value: _selectedStructure,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    if (_selectedStructure != newValue) {
                      setState(() {
                        _selectedStructure = newValue;
                        _selectedStage = null;
                        getStageDropdown(newValue);
                      });

                    }
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: structureList.map<DropdownMenuItem<String>>((
                      Map value) {
                    return DropdownMenuItem<String>(
                      value: value['structureId'].toString(),
                      child: Text(value['structureName'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedStructure == null
                    ? const SizedBox.shrink()
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select Stage',
                    labelStyle: const TextStyle(
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
                  value: _selectedStage,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStage = newValue;
                      getUnitDropdown(newValue);
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: stageList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['stageid'].toString(),
                      child: Text(value['stageName'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedStage == null
                    ? const SizedBox.shrink()
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select Unit',
                    labelStyle: const TextStyle(
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
                  value: _selectedUnit,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedUnit = newValue;
                      getSubUnitDropdown(newValue);
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: unitList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['unitid'].toString(),
                      child: Text(value['unitName'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedUnit == null
                    ? const SizedBox.shrink()
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select SubUnit',
                    labelStyle: const TextStyle(
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
                  value: _selectedSubUnit,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSubUnit = newValue;
                      // getUnitDropdown(newValue);
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: subUnitList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['subUnitId'].toString(),
                      child: Text(value['subUnitName'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedSubUnit == null
                    ? const SizedBox.shrink()
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select CheckList',
                    labelStyle: const TextStyle(
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
                  value: _selectedCheckList,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCheckList = newValue;
                       getGroupListDropdown(newValue);
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: checkList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['chklId'].toString(),
                      child: Text(value['chklName'].toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _selectedSubUnit == null
                    ? const SizedBox.shrink()
                    // : isLoading
                    // ? const CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0),
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Select Group',
                    labelStyle: const TextStyle(
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
                  value: _selectedGroupList,
                  icon: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGroupList = newValue;
                      // getUnitDropdown(newValue);
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? ''
                      : null,
                  items: groupList.map<DropdownMenuItem<String>>((Map value) {
                    return DropdownMenuItem<String>(
                      value: value['groupId'].toString(),
                      child: Text(value['groupName'].toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getClientDropdown() async {
    try {
      final response = await dio.get(Api.Client,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          clientList = List<Map<String, dynamic>>.from(response.data);
          print(clientList);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch clients: ${e.message}')),
      );
    }
    AllocateData.ClientId;
  }

  void getProjectDropdown(String? clientId) async {
    if (clientId == null) return;
    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.project + _selectedClient.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          projectList = List<Map<String, dynamic>>.from(response.data);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }

  void getStrutureDropdown(newValue) async {

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.Struture+_selectedClient.toString()+'/'+_selectedProject.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          structureList = List<Map<String, dynamic>>.from(response.data);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }

  void getStageDropdown(newValue) async {

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.Stage+_selectedClient.toString()+'/'+_selectedProject.toString()+'/'+_selectedStructure.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          stageList = List<Map<String, dynamic>>.from(response.data);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }

  void getUnitDropdown(newValue) async {

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.Unit+_selectedClient.toString()+'/'+_selectedProject.toString()+'/'+_selectedStructure.toString()+'/'+_selectedStage.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          unitList = List<Map<String, dynamic>>.from(response.data);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }

  void getSubUnitDropdown(newValue) async {

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.Subunit+_selectedClient.toString()+'/'+_selectedProject.toString()+'/'+_selectedStructure.toString()+'/'+_selectedStage.toString()+'/'+_selectedUnit.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          subUnitList = List<Map<String, dynamic>>.from(response.data);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }

  void getCheckListDropdown(newValue) async {

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.Checklist+_selectedClient.toString()+'/'+_selectedProject.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          checkList = List<Map<String, dynamic>>.from(response.data);
          print(checkList);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }
  void getGroupListDropdown(newValue) async {

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(Api.Group+_selectedCheckList.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the Authorization header
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          groupList = List<Map<String, dynamic>>.from(response.data);
          print(groupList);
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch projects: ${e.message}')),
      );
    }
  }
}


