import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scholer/Notes/students/studentdrawer.dart';

import '../../signupservices.dart';

class studentattendancesem1 extends StatefulWidget {
  var subjectselect;
  var sem;
  studentattendancesem1();

  @override
  State<studentattendancesem1> createState() => _studentattendancesem1State();
}

class _studentattendancesem1State extends State<studentattendancesem1> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 63, 131, 1),
          title: Text("Attendance"),
        ),
        endDrawer: studentdrawer(false),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("attendance_sem 1")
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
                      var notes = snapshot.data!.docs[index];
                      int AOP = snapshot.data!.docs[index]["AOP"];
                      int AOPtotal = snapshot.data!.docs[index]["AOP_total"];
                      double AOPper = (AOP * 100) / AOPtotal;
                      int OOP = snapshot.data!.docs[index]["OOP"];
                      int OOPtotal = snapshot.data!.docs[index]["OOP_total"];
                      double OOPper = (OOP * 100) / OOPtotal;
                      int DS = snapshot.data!.docs[index]["DS"];
                      int DStotal = snapshot.data!.docs[index]["DS_total"];
                      double DSper = (DS * 100) / DStotal;
                      int COA = snapshot.data!.docs[index]["COA"];
                      int COAtotal = snapshot.data!.docs[index]["COA_total"];
                      double COAper = (COA * 100) / COAtotal;
                      int TOC = snapshot.data!.docs[index]["TOC"];
                      int TOCtotal = snapshot.data!.docs[index]["TOC_total"];
                      double TOCper = (TOC * 100) / TOCtotal;
                      int DM = snapshot.data!.docs[index]["DM"];
                      int DMtotal = snapshot.data!.docs[index]["DM_total"];
                      double DMper = (DM * 100) / DMtotal;
                      return Center(
                          child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 143, 137, 137),
                              blurRadius: 50,
                              // spreadRadius: 0,
                              offset: Offset(5, 5))
                        ]),
                        width: double.infinity,
                        //height: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Card(
                          color: Color.fromRGBO(223, 225, 225, 1),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 44, 43, 43),
                                          blurRadius: 10,
                                          offset: Offset(5, 5))
                                    ],
                                    color: Color.fromRGBO(202, 213, 213, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    top: 20, bottom: 6, left: 20, right: 20),
                                height: 80,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "AOP - 1MCA1",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    //fontFamily: "Ysabeau",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "$AOP/$AOPtotal Classes attended"),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularPercentIndicator(
                                        animation: true,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        radius: 30.0,
                                        lineWidth: 5.0,
                                        percent: AOPper / 100,
                                        center: Text(
                                            "${AOPper.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)
                                            //style: TextStyle(fontSize: 18),
                                            ),
                                        progressColor:
                                            Color.fromRGBO(96, 63, 131, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 44, 43, 43),
                                          blurRadius: 10,
                                          offset: Offset(5, 5))
                                    ],
                                    color: Color.fromRGBO(202, 213, 213, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    top: 15, bottom: 6, left: 20, right: 20),
                                height: 80,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "DM - 1MCA2",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    //fontFamily: "Ysabeau",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("$DM/$DMtotal Classes attended"),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularPercentIndicator(
                                        animation: true,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        radius: 30.0,
                                        lineWidth: 5.0,
                                        percent: DMper / 100,
                                        center: Text(
                                          "${DMper.toStringAsFixed(0)}%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        progressColor:
                                            Color.fromRGBO(96, 63, 131, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 44, 43, 43),
                                          blurRadius: 10,
                                          offset: Offset(5, 5))
                                    ],
                                    color: Color.fromRGBO(202, 213, 213, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    top: 15, bottom: 6, left: 20, right: 20),
                                height: 80,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "COA - 1MCA3",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    //fontFamily: "Ysabeau",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "$COA/$COAtotal Classes attended"),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularPercentIndicator(
                                        animation: true,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        radius: 30.0,
                                        lineWidth: 5.0,
                                        percent: COAper / 100,
                                        center: Text(
                                            "${COAper.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)
                                            //style: TextStyle(fontSize: 18),
                                            ),
                                        progressColor:
                                            Color.fromRGBO(96, 63, 131, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 44, 43, 43),
                                          blurRadius: 10,
                                          offset: Offset(5, 5))
                                    ],
                                    color: Color.fromRGBO(202, 213, 213, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    top: 15, bottom: 6, left: 20, right: 20),
                                height: 80,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "TOC - 1MCA4",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    //fontFamily: "Ysabeau",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "$TOC/$TOCtotal Classes attended"),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularPercentIndicator(
                                        animation: true,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        radius: 30.0,
                                        lineWidth: 5.0,
                                        percent: TOCper / 100,
                                        center: Text(
                                            "${TOCper.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)
                                            //style: TextStyle(fontSize: 18),
                                            ),
                                        progressColor:
                                            Color.fromRGBO(96, 63, 131, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 44, 43, 43),
                                          blurRadius: 10,
                                          offset: Offset(5, 5))
                                    ],
                                    color: Color.fromRGBO(202, 213, 213, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    top: 15, bottom: 6, left: 20, right: 20),
                                height: 80,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "OOP - 1MCA5",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    //fontFamily: "Ysabeau",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "$OOP/$OOPtotal Classes attended"),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularPercentIndicator(
                                        animation: true,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        radius: 30.0,
                                        lineWidth: 5.0,
                                        percent: OOPper / 100,
                                        center: Text(
                                            "${OOPper.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)
                                            //style: TextStyle(fontSize: 18),
                                            ),
                                        progressColor:
                                            Color.fromRGBO(96, 63, 131, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 44, 43, 43),
                                          blurRadius: 10,
                                          offset: Offset(5, 5))
                                    ],
                                    color: Color.fromRGBO(202, 213, 213, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    top: 15, bottom: 30, left: 20, right: 20),
                                height: 80,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "DS - 1MCA6",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    //fontFamily: "Ysabeau",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("$DS/$DStotal Classes attended"),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularPercentIndicator(
                                        animation: true,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        radius: 30.0,
                                        lineWidth: 5.0,
                                        percent: DSper / 100,
                                        center: Text(
                                            "${DSper.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)
                                            //style: TextStyle(fontSize: 18),
                                            ),
                                        progressColor:
                                            Color.fromRGBO(96, 63, 131, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // LinearPercentIndicator(
                              //   lineHeight: 50,
                              //   barRadius: Radius.circular(5),
                              //   // radius: 85.0,
                              //   // lineWidth: 30.0,
                              //   percent: OOPper / 100,
                              //   center: Text(
                              //     "${OOPper.toStringAsFixed(2)}%",
                              //     style: TextStyle(fontSize: 18),
                              //   ),
                              //   progressColor: Color.fromRGBO(96, 63, 131, 1),
                              // ),
                              //for (var i = 0; i < count; i = i + 2)
                              // Container(
                              //   margin: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //       border: Border.all(width: 2),
                              //       color: Color.fromRGBO(202, 213, 213, 1)),
                              //   child: InkWell(
                              //     child: Container(
                              //       child: Text("${notes["DS"]}"),
                              //     ),
                              //   ),
                              // ),
                              // InkWell(
                              //   child: Container(
                              //     child: Text("${notes["DM"]}"),
                              //   ),
                              // ),
                              // InkWell(
                              //   child: Container(
                              //     child: Text("${notes["AOP"]}"),
                              //   ),
                              // ),
                              // InkWell(
                              //   child: Container(
                              //     child: Text("${notes["COA"]}"),
                              //   ),
                              // ),
                              // InkWell(
                              //   child: Container(
                              //     child: Text("${notes["TOC"]}"),
                              //   ),
                              // ),
                              // InkWell(
                              //   child: Container(
                              //     child: Text("${notes["OOP"]}"),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ));
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
      ),
    );
  }
}

//  Column(
//                           children: [
//                             LinearPercentIndicator(
//                               lineHeight: 30,
//                               barRadius: Radius.circular(20),
//                               // radius: 85.0,
//                               // lineWidth: 30.0,
//                               percent: OOPper / 100,
//                               center: Text(
//                                 "${OOPper.toStringAsFixed(2)}%",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               progressColor: Color.fromRGBO(96, 63, 131, 1),
//                             ),
//                             //for (var i = 0; i < count; i = i + 2)
//                             Container(
//                               margin: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   border: Border.all(width: 2),
//                                   color: Color.fromRGBO(202, 213, 213, 1)),
//                               child: InkWell(
//                                 child: Container(
//                                   child: Text("${notes["DS"]}"),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               child: Container(
//                                 child: Text("${notes["DM"]}"),
//                               ),
//                             ),
//                             InkWell(
//                               child: Container(
//                                 child: Text("${notes["AOP"]}"),
//                               ),
//                             ),
//                             InkWell(
//                               child: Container(
//                                 child: Text("${notes["COA"]}"),
//                               ),
//                             ),
//                             InkWell(
//                               child: Container(
//                                 child: Text("${notes["TOC"]}"),
//                               ),
//                             ),
//                             InkWell(
//                               child: Container(
//                                 child: Text("${notes["OOP"]}"),
//                               ),
//                             ),
//                           ],
//                         ),