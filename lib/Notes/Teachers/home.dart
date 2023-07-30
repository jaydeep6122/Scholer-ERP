// ignore_for_file: prefer_conditional_assignment

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:scholer/Notes/Teachers/teachernotes.dart';

import 'package:scholer/signupservices.dart';

import '../../selection.dart';
import 'attendance.dart';
import 'feedback.dart';

// void main() async {
//   //timechageforeveryone
//   const onemin = Duration(seconds: 5);
//   Timer.periodic(onemin, (Timer t) => timechageforeveryone());
// }

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
  // ignore: library_private_types_in_public_api
  _homeState setState() => _homeState();
}

StreamSubscription<GeofenceStatus>? geofenceStatusStream;
String geofenceStatus = '';

bool location = false;
bool isbuttonactive = false;

// void getlocation() async {
//   await Geolocator.checkPermission();
//   await Geolocator.requestPermission();
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);

//   var currlatitude = position.latitude;
//   var currlongtitude = position.longitude;
//   print("$currlatitude" + " " + "$currlongtitude");
// }

DateTime date = DateTime.now();
String time = "${date.hour}.${date.minute}";
double cur = double.parse('$time');

class _homeState extends State<home> {
  void staffroomlocation() {
    EasyGeofencing.startGeofenceService(
        pointedLatitude: "13.0856934",
        pointedLongitude: "77.4849855",
        radiusMeter: "100.0",
        eventPeriodInSeconds: 100);
    if (geofenceStatusStream == null) {
      geofenceStatusStream =
          EasyGeofencing.getGeofenceStream()!.listen((GeofenceStatus status) {
        if (status.toString() == "GeofenceStatus.enter") {
          if (cur > 9.00) {
            setState(() {
              location = true;
              isbuttonactive = true;
            });
          }

          print("True");
        } else {
          isbuttonactive = false;
          print("False");
        }
        //print(status.toString());
        setState(() {
          geofenceStatus = status.toString();
        });
      });
    }
  }

  @override
  void initState() {
    setState(() {
      staffroomlocation();
      total;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("teacherprofile")
                          .where("uid", isEqualTo: user!.uid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        if (snapshot != null && snapshot.data != null) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var name = snapshot.data!.docs[index]["name"];

                                var image =
                                    snapshot.data!.docs[index]["profile_pic"];

                                return Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(image),
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(name),
                                    ],
                                  ),
                                );
                              });
                        }

                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: () {
                Get.to(() => home());
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text(
                "Attendance",
                style: TextStyle(
                    color: isbuttonactive ? Colors.black : Colors.red),
              ),
              onTap: isbuttonactive
                  ? () async {
                      await attendance();
                      await attendancetimechange();
                      setState(() {
                        isbuttonactive = false;
                      });
                    }
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Notes"),
              onTap: () {
                //Get.to(() => teachernotes());
                Get.to(() => teachernotes());
              },
            ),
            ListTile(
              leading: Icon(Icons.addchart),
              title: Text("Student Attendance"),
              onTap: () {
                Get.to(() => attendancesem());
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.work),
            //   title: Text("Jobs"),
            //   onTap: () {
            //     Get.to(() => joblist());
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text("Feedback"),
              onTap: () {
                //getlocation();
                //getDataOnce_multipleDocumentsFromACollection();
                Get.to(() => feedback());
                //getdoc();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(() => selecton());
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.notifications_none),
        title: const Text("Dashbord"),
        backgroundColor: Color.fromRGBO(96, 63, 131, 1),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("teacherprofile")
              .where("uid", isEqualTo: user.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var name = snapshot.data!.docs[index]["name"];
                    var email = snapshot.data!.docs[index]["email"];
                    var phone = snapshot.data!.docs[index]["mobile"];
                    var image = snapshot.data!.docs[index]["profile_pic"];

                    int attend = snapshot.data!.docs[index]["attendance"];
                    int totalattend = snapshot.data!.docs[index]["total"];
                    bool attendancetime = snapshot.data!.docs[index]["time"];
                    if (attendancetime) {
                      staffroomlocation();
                      //isbuttonactive = true;
                    } else {
                      isbuttonactive = false;
                    }
                    var per = ((attend / totalattend) * 100);

                    attendancee = attend;
                    total = totalattend;

                    // DateTime date = DateTime.now();
                    // String time = "${date.hour}.${date.minute}.${date.second}";

                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 35, fontFamily: "GreatVibes"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  spreadRadius: 5,
                                  offset: Offset(5, 5),
                                  blurRadius: 10,
                                  color: Colors.grey)
                            ]),
                            child: Image.network(
                              image,
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            name.toString(),
                            style: TextStyle(
                                fontSize: 22, fontFamily: "Courgette"),
                          ),
                          Text(
                            email.toString(),
                            style:
                                TextStyle(fontSize: 22, fontFamily: "Ysabeau"),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            phone.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Center(
                                    child: Text(
                                  "Attendance",
                                  style: TextStyle(
                                      fontFamily: "Courgette", fontSize: 20),
                                )),
                                height: 50,
                                width: 350,
                                color: Color.fromRGBO(202, 213, 213, 1),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CircularPercentIndicator(
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 85.0,
                            lineWidth: 30.0,
                            percent: per / 100,
                            center: Text(
                              "${per.toStringAsFixed(2)}%",
                              style: TextStyle(fontSize: 18),
                            ),
                            progressColor: Color.fromRGBO(96, 63, 131, 1),
                          )
                        ],
                      ),
                    );
                  });
            }
            // if (snapshot.connectionState ==
            //     ConnectionState.active) {
            //   QuerySnapshot querySnapshot = snapshot.data;
            // }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
