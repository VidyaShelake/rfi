import 'package:flutter/material.dart';
import 'package:rfi/pages/rfiQuestions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

class Createrfi2 extends StatefulWidget {
  const Createrfi2({super.key});

  @override
  State<Createrfi2> createState() => _Createrfi2State();
}

class _Createrfi2State extends State<Createrfi2> {
  String? _selectedClient; // Selected client ID
  List<Map<String, dynamic>> clientList = [];
  String? _selectedClientId;
  String? _selectedClientName;

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
    });
  }
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
                    Column(
                      children: [
                        // DropdownButtonFormField to select client
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: "Select Client",
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedClientId, // Use the loaded client ID
                          items: clientList.map<DropdownMenuItem<String>>((client) {
                            return DropdownMenuItem<String>(
                              value: client['cl_id'].toString(),
                              child: Text(client['cl_name']), // Display client name in dropdown
                            );
                          }).toList(),
                          onChanged: (value) {
                            // Update selected client ID and name
                            setState(() {
                              _selectedClientId = value;

                              // Find and update selected client name based on ID
                              var selectedClient = clientList.firstWhere(
                                    (client) => client['cl_id'].toString() == value,
                                orElse: () => {"cl_name": "Unknown"}, // Fallback in case of no match
                              );
                              _selectedClientName = selectedClient['cl_name'];
                            });
                          },
                        ),
                        SizedBox(height: 16), // Add some spacing
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                          "Select WorkType ",
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
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                          "Select Struture ",
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
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                      },
                      items:
                          clientList.map<DropdownMenuItem<String>>((Map value) {
                        return DropdownMenuItem<String>(
                          value: value['cl_id'].toString(),
                          child: Text(value['cl_name'].toString()),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
