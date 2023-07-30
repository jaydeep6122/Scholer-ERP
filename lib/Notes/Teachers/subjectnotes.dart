import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../../signupservices.dart';
import 'drawer.dart';

class subjectnotes extends StatefulWidget {
  var subjectselect;
  var sem;

  subjectnotes(this.subjectselect, this.sem);

  @override
  State<subjectnotes> createState() => _subjectnotesState();
}

class _subjectnotesState extends State<subjectnotes> {
  @override
  Widget build(BuildContext context) {
    PlatformFile? pikedFile;
    TextEditingController filenamecontroller = TextEditingController();
    //to pick file from mobile
    Future selectfile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result == null) return;
      setState(() {
        pikedFile = result.files.first;
      });
    }

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 63, 131, 1),
          title: Text("${widget.subjectselect} notes"),
        ),
        endDrawer: drawer(),
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
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              for (var i = 0; i < count; i = i + 2)
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 197, 196, 196)),
                                      color: Color.fromRGBO(202, 213, 213, 1)),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "${notes["notes"][i]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        //padding: EdgeInsets.only(left: size.width * .048,),
                                        child: IconButton(
                                            onPressed: () {
                                              removenotes(
                                                  widget.sem,
                                                  "${notes["notes"][i + 1]}",
                                                  "${notes["notes"][i]}",
                                                  widget.subjectselect);
                                            },
                                            icon: Icon(
                                                Icons.delete_forever_rounded)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
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
                              SizedBox(
                                height: 20,
                              ),

                              // Text Button
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)),
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(1, 79, 134, 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Center(
                                              child: Center(
                                                  child: Text(
                                            "Upload Document",
                                          ))),
                                          actions: [
                                            Center(
                                              child: Container(
                                                width: 270,
                                                child: TextFormField(
                                                  controller:
                                                      filenamecontroller,
                                                  decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.grey.shade100,
                                                      filled: true,
                                                      hintText: "Notes Name",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: TextButton(
                                                  onPressed: () async {
                                                    await selectfile();
                                                  },
                                                  child: Text("Select File")),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color.fromRGBO(
                                                      1, 79, 134, 20),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: const Text("Upload"),
                                              onPressed: () async {
                                                var notesname =
                                                    filenamecontroller.text
                                                        .trim();
                                                Reference referenceRoot =
                                                    FirebaseStorage.instance
                                                        .ref();
                                                Reference Imagedirectory =
                                                    referenceRoot.child(
                                                        "${widget.sem.toString()}");
                                                Reference uplodeimage =
                                                    Imagedirectory.child(
                                                        "${userid!.uid}.pdf");
                                                try {
                                                  await uplodeimage.putFile(
                                                      File(pikedFile!.path!));
                                                  final snapshot =
                                                      await uplodeimage
                                                          .getDownloadURL();
                                                  await addnotes(
                                                      widget.sem.toString(),
                                                      snapshot,
                                                      notesname,
                                                      widget.subjectselect);

                                                  Navigator.of(context).pop();
                                                } catch (e) {}
                                              },
                                            ),
                                          ],
                                        ));
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Upload Notes",
                                    style: TextStyle(fontSize: 15),
                                  ),
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
