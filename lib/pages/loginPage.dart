
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rfi/constants/apiList.dart';
import 'package:rfi/constants/baseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
 // static var ClientId;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

var employeeName;

  final Dio dio = Dio();
  String? valueDropdown;
  List<Map> rfiList = [];
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Login Page',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 80), // Spacing between dropdowns

                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.person, // Change to your desired icon
                              color: Colors.black38,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.lock, // Password icon
                              color: Colors.black38,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.black38,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      OutlinedButton(
                        onPressed: () async {
                          if (userController.text.isEmpty ) {
                             Fluttertoast.showToast(
                             msg: "please enter valid UsserName",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                              );

                            } else {
                               postDropdown();
                            }
                          },

                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<bool> postDropdown() async {
    try {
      final postData = {
        'username': userController.text.trim(),
        'password': passController.text.trim(),
      };

      final response = await dio.post(
        Api.Login, // Replace with your actual POST endpoint
        data: postData,
      );
      print( postData);

      if (response.statusCode == 200) {
        final data = response.data;

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        await sharedPreferences.setString(Constants.TOKEN, data['accessToken']);
        await sharedPreferences.setString(Constants.TOKENTYPE, data['tokenType']);
        await sharedPreferences.setString(Constants.ID, data['id'].toString());
        await sharedPreferences.setString(Constants.USERNAME, data['username']);
        await sharedPreferences.setString(Constants.EMAIL, data['email']);
        await sharedPreferences.setString(Constants.USERFULLNAME, data['userfullname']);
        await sharedPreferences.setString(Constants.ROLES, jsonEncode(data['roles']));
        await sharedPreferences.setString(Constants.ROLEID, data['roleId'].toString());
        await sharedPreferences.setString(Constants.REPRESENTINGTYPE, data['representingType'].toString());
        // LoginPage.ClientId;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()),
        );

        return true;
      } else {
        _showErrorToast("Failed to login. Please check your credentials.");
        return false;
      }
    } on DioError catch (e) {
      _showErrorToast("Error: ${e.message}");
      return false;
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}





