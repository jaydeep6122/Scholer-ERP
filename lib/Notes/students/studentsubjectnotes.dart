import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:scholer/Notes/students/studentdrawer.dart';

import '../../signupservices.dart';

class studentsubjectnotes extends StatefulWidget {
  var subjectselect;
  var sem;
  studentsubjectnotes(this.subjectselect, this.sem);

  @override
  State<studentsubjectnotes> createState() => _studentsubjectnotesState();
}

class _studentsubjectnotesState extends State<studentsubjectnotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 63, 131, 1),
          title: Text("${widget.subjectselect} notes"),
        ),
        endDrawer: studentdrawer(false),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("${widget.sem}")
                .where("subject", isEqualTo: "${widget.subjectselect}")
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
                      for (var i in notes["notes"]) {
                        count++;
                      }
                      return Center(
                        child: Container(
                          //padding: EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              for (var i = 0; i < count; i = i + 2)
                                Container(
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 197, 196, 196)),
                                      color: Color.fromRGBO(202, 213, 213, 1)),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "${notes["notes"][i]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child: IconButton(
                                            onPressed: () async {
                                              var url = notes["notes"][i + 1];
                                              final File? file =
                                                  await FileDownloader
                                                      .downloadFile(
                                                          url: url,
                                                          name: notes["notes"]
                                                                  [i]
                                                              .toString());
                                            },
                                            icon: Icon(Icons.download)),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
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
      ),
    );
  }
}
