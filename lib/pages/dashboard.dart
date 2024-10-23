import 'package:flutter/material.dart';
import 'package:rfi/pages/uploadData.dart';
import 'package:rfi/pages/uploadImage.dart';

import 'AllocateData2.dart';
import 'allocateData.dart';
import 'createRFI.dart';
import 'createRFI2.dart';
import 'dashboardDrawer.dart';
import 'loginPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text('Home Page'),
        //   actions: [
        //     PopupMenuButton<String>(
        //       icon: Icon(Icons.more_vert),
        //       onSelected: (String result) {
        //         if (result == 'Refresh') {
        //           // Handle Refresh
        //           print('Refresh clicked');
        //         } else if (result == 'Logout') {
        //           // Handle Logout
        //           Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => LoginPage()),
        //           );
        //           print('Logout clicked');
        //         }
        //       },
        //       itemBuilder: (BuildContext context) => [
        //         PopupMenuItem<String>(
        //           value: 'Refresh',
        //           child: Text('Refresh'),
        //         ),
        //         PopupMenuItem<String>(
        //           value: 'Logout',
        //           child: Text('Logout'),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(builder: (context) => LoginPage()),
          //     );
          //   },
          //
          // ),
          title: const Text(
            'Dashboard',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        drawer: Drawer(
          child: Dashboarddrawer(), // Use DashboardDrawer here
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Allocatedata2()));
                      },
                      child: Card(
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Center(
                                  child: Column(
                            children: [
                              Image.asset(
                                'assets/images/obser.jpg', // Update with your image path
                                height: 100, // Adjust height as needed
                              ),
                              Text("Allocate Data",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'poppins')),
                            ],
                          ))),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.black, thickness: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Createrfi()));
                      },
                      child: Card(
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Center(
                                  child: Column(
                            children: [
                              Image.asset(
                                'assets/images/obser.jpg', // Update with your image path
                                height: 100, // Adjust height as needed
                              ),
                              Text("Create RFI",
                                  style: TextStyle(
                                      fontSize: 23, fontFamily: 'poppins')),
                            ],
                          ))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // _showCardiology(context);
                      },
                      child: Card(
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Center(
                                  child: Column(
                            children: [
                              Image.asset(
                                'assets/images/obser.jpg', // Update with your image path
                                height: 100, // Adjust height as needed
                              ),
                              Text("Update RFI",
                                  style: TextStyle(
                                      fontSize: 23, fontFamily: 'poppins')),
                            ],
                          ))),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // _showGynecology(context);
                      },
                      child: Card(
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Center(
                                  child: Column(
                            children: [
                              Image.asset(
                                'assets/images/obser.jpg', // Update with your image path
                                height: 100, // Adjust height as needed
                              ),
                              Text("Dashboard",
                                  style: TextStyle(
                                      fontSize: 23, fontFamily: 'poppins')),
                            ],
                          ))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20), // Add some space before the new card
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround, // Adjusts spacing between cards
              //   children: [
              //
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(builder: (context) => Uploaddata()),
              //         );
              //       },
              //       child: Card(
              //         color: Colors.greenAccent,
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(
              //                   Icons.upload, // Replace with your desired icon
              //                   size: 50, // Adjust icon size as needed
              //                   color: Colors.black,
              //                 ),
              //                 SizedBox(height: 10), // Add space between icon and text
              //                 Text(
              //                   "Upload Data", // Your text here
              //                   style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       // onTap: () {
              //       //   Navigator.pushReplacement(
              //       //     context,
              //       //     MaterialPageRoute(builder: (context) => UploadImage()),
              //       //   );
              //       // },
              //       child: Card(
              //         color: Colors.greenAccent, // You can change the color as needed
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(
              //                   Icons.image, // Replace with your desired icon
              //                   size: 50, // Adjust icon size as needed
              //                   color: Colors.black,
              //                 ),
              //                 SizedBox(height: 10), // Add space between icon and text
              //                 Text(
              //                   "Upload Image", // Your text here
              //                   style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ]),
          ),
        ));
  }
}
