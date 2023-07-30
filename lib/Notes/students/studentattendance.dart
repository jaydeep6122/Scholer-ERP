import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:scholer/Notes/Teachers/drawer.dart';
import 'package:scholer/Notes/students/studentattendancesem1.dart';
import 'package:scholer/Notes/students/studentdrawer.dart';

import 'package:scholer/Notes/students/studentsubject.dart';

import 'package:scholer/signupservices.dart';

class studentattendance extends StatefulWidget {
  const studentattendance({super.key});

  @override
  State<studentattendance> createState() => _studentattendanceState();
}

class _studentattendanceState extends State<studentattendance> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Notes"),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(96, 63, 131, 1),
            ),
            endDrawer: studentdrawer(true),
            body: Center(
                child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 20,
                  color: Color.fromRGBO(214, 223, 223, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Center(
                        child: TextButton(
                            onPressed: () {
                              Get.to(() => studentattendancesem1());
                            },
                            child: Text('Semester - 1',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)))),
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 20,
                  color: Color.fromRGBO(193, 203, 203, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Center(
                        child: TextButton(
                            onPressed: () {
                              //  Get.to(() => studentsubject("sem 2"));
                            },
                            child: Text('Semester - 2',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)))),
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 20,
                  color: Color.fromRGBO(168, 177, 177, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Center(
                        child: TextButton(
                            onPressed: () {
                              //   Get.to(() => studentsubject("sem 3"));
                            },
                            child: Text('Semester - 3',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)))),
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 20,
                  color: Color.fromRGBO(144, 152, 152, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Center(
                        child: TextButton(
                            onPressed: () {
                              // Get.to(() => studentsubject("sem 4"));
                            },
                            child: Text('Semester - 4',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)))),
                  )),
            ]))));
  }
}
