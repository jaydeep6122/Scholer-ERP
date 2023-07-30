import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/subject.dart';

import 'package:scholer/Notes/Teachers/drawer.dart';

import '../../signupservices.dart';

class teachersem1notes extends StatefulWidget {
  const teachersem1notes({super.key});

  @override
  State<teachersem1notes> createState() => _teachersem1notesState();
}

class _teachersem1notesState extends State<teachersem1notes> {
  PlatformFile? pikedFile;
  TextEditingController semController = TextEditingController();
  TextEditingController filenamecontroller = TextEditingController();
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

  var subjectvalue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Teacher Sem 1 notes"),
        ),
        endDrawer: drawer(),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sem 1")
                .where("subject", isEqualTo: "java")
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
                        child: Column(
                          children: [
                            for (var i = 0; i < count; i = i + 2)
                              TextButton(
                                  onPressed: () {},
                                  child: Text("${notes["notes"][i]}")),
                            for (var j = 0; j < 1; j++)
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                          child: AlertDialog(
                                        title: Text("Upload Document"),
                                        actions: [
                                          TextFormField(
                                            controller: filenamecontroller,
                                            decoration: InputDecoration(
                                                suffixIcon: const Icon(
                                                    Icons.numbers_rounded),
                                                fillColor: Colors.grey.shade100,
                                                filled: true,
                                                hintText: "Notes Name",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                )),
                                          ),
                                          Center(
                                            child: TextButton(
                                                onPressed: () async {
                                                  await selectfile();
                                                },
                                                child: Text("Select File")),
                                          ),
                                          TextButton(
                                            child: const Text("Upload"),
                                            onPressed: () async {
                                              var notesname = filenamecontroller
                                                  .text
                                                  .trim();
                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference Imagedirectory =
                                                  referenceRoot
                                                      .child("${1.toString()}");
                                              Reference uplodeimage =
                                                  Imagedirectory.child(
                                                      "${userid!.uid}.pdf");
                                              try {
                                                await uplodeimage.putFile(
                                                    File(pikedFile!.path!));
                                                final snapshot =
                                                    await uplodeimage
                                                        .getDownloadURL();
                                              } catch (e) {}
                                            },
                                            // controller: phoneController,
                                          ),
                                        ],
                                      ));
                                    },
                                  );
                                },
                                child: Text("Upload Notes"),
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
      ),
    );
  }
}
