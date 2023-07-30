import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../signupservices.dart';
import 'drawer.dart';

class studentlist extends StatefulWidget {
  var subjectselect;
  var sem;
  studentlist(this.subjectselect, this.sem);

  @override
  State<studentlist> createState() => _studentlistState();
}

class _studentlistState extends State<studentlist> {
  List<String> temarray = [];
  List<int> tempattendance = [];
  List<int> temptotal = [];
  @override
  Widget build(BuildContext context) {
    PlatformFile? pikedFile;
    TextEditingController semController = TextEditingController();
    TextEditingController filenamecontroller = TextEditingController();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 63, 131, 1),
          title: Text("${widget.subjectselect} Attendance"),
        ),
        endDrawer: drawer(),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("${widget.sem}")
                //.where("subject", isEqualTo: "${widget.subjectselect}")
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

                      int count = 0;
                      // for (var i in notes) {
                      //   count++;
                      // }

                      int p = notes["${widget.subjectselect}"];
                      int t = notes["${widget.subjectselect}_total"];
                      tt = t;
                      double per = (p * 100) / t;
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "${notes["name"]}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                            "${per.toStringAsFixed(1)}%",
                                            style: TextStyle(
                                                color: Colors.black))),
                                  ),
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: Text(
                                  //         "${(notes["attendance"][i + 2] / notes["total"]) * 100}%")),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    color: temarray.contains("${notes["uid"]}")
                                        ? Colors.green
                                        : Colors.red,
                                    height: 30,
                                    width: 30,
                                    child: InkWell(
                                      child: Center(
                                          child: temarray
                                                  .contains("${notes["uid"]}")
                                              ? const Text(
                                                  "P",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )
                                              : const Text(
                                                  "A",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )),
                                      onTap: () {
                                        setState(() {
                                          if (temarray
                                              .contains("${notes["uid"]}")) {
                                            temarray.remove("${notes["uid"]}");
                                            tempattendance.remove(notes[
                                                "${widget.subjectselect}"]);
                                          } else {
                                            temarray.add("${notes["uid"]}");
                                            tempattendance.add(notes[
                                                "${widget.subjectselect}"]);
                                          }
                                        });
                                        // print(temarray.toString());
                                        // print(tempattendance.toString());
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        persistentFooterButtons: <Widget>[
          TextButton(
              onPressed: () {
                addstudentattendance(widget.sem, '${widget.subjectselect}',
                    temarray, tempattendance);
                temarray = [];
                tempattendance = [];
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
