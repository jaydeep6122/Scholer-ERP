import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/subject.dart';
import 'package:scholer/Notes/Teachers/teachersem1.dart';

import 'package:scholer/Notes/Teachers/drawer.dart';
import 'package:scholer/signupservices.dart';

import 'attendancesubject.dart';

class attendancesem extends StatefulWidget {
  const attendancesem({super.key});

  @override
  State<attendancesem> createState() => _attendancesemState();
}

class _attendancesemState extends State<attendancesem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("attendancesem"),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(96, 63, 131, 1),
          ),
          endDrawer: drawer(),
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Card(
                    elevation: 20,
                    color: const Color.fromRGBO(214, 223, 223, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Center(
                          child: TextButton(
                              onPressed: () {
                                Get.to(() => attendancesubject("sem 1"));
                              },
                              child: const Text('Semester - 1',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)))),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Card(
                    elevation: 20,
                    color: const Color.fromRGBO(193, 203, 203, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Center(
                          child: TextButton(
                              onPressed: () {
                                Get.to(() => attendancesubject("sem 2"));
                              },
                              child: const Text('Semester - 2',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)))),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Card(
                    elevation: 20,
                    color: const Color.fromRGBO(168, 177, 177, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Center(
                          child: TextButton(
                              onPressed: () {
                                Get.to(() => attendancesubject("sem 3"));
                              },
                              child: const Text('Semester - 3',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)))),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Card(
                    elevation: 20,
                    color: const Color.fromRGBO(144, 152, 152, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Center(
                          child: TextButton(
                              onPressed: () {
                                Get.to(() => attendancesubject("sem 4"));
                              },
                              child: const Text('Semester - 4',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)))),
                    )),
              ],
            ),
          )),
    );
  }
}


// Center(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("notes")
//                 //.where("sem", isEqualTo: 1.toString())
//                 .snapshots(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text(snapshot.error.toString()));
//               }
//               if (snapshot != null && snapshot.data != null) {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var DS = snapshot.data!.docs[index];
//                       // var math = snapshot.data!.docs[index];
//                       // int count = 0;
//                       // int count2 = 0;
//                       // for (var i in DS["DS"]) {
//                       //   count++;
//                       // }
//                       // for (var i in math["Math"]) {
//                       //   count2++;
//                       // }
//                       var a = snapshot.data!.docs.length;
//                       return Center(
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 20,
//                             ),
//                             // Text("${a}"),
//                             // for (var i = 0; i < 1; i++)
//                             Card(
//                                 elevation: 20,
//                                 color: Color.fromARGB(255, 254, 182, 87),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: SizedBox(
//                                   width: 300,
//                                   height: 80,
//                                   child: Center(
//                                       child: TextButton(
//                                           onPressed: () {
//                                             Get.to(() => teachersem1notes());
//                                           },
//                                           child: Text("Semester - ${DS["sem"]}",
//                                               style: TextStyle(
//                                                   fontSize: 25,
//                                                   color: Colors.white)))),
//                                 )),
//                             SizedBox(
//                               height: 20,
//                             )
//                             // Text("Math"),
//                             // for (var i = 1; i < count2; i = i + 2)
//                             //   TextButton(
//                             //       onPressed: () async {
//                             //         var url = math["Math"][i + 1];
//                             //         final File? file =
//                             //             await FileDownloader.downloadFile(
//                             //                 url: url, name: i.toString());
//                             //       },
//                             //       child: Text("${math["Math"][i]}")),
//                           ],
//                         ),
//                       );
//                     });
//               }

//               return Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),

  // Center(
  //             child: StreamBuilder<QuerySnapshot>(
  //               stream: FirebaseFirestore.instance
  //                   .collection("teacherprofile")
  //                   .where("uid", isEqualTo: userid!.uid)
  //                   .snapshots(),
  //               builder: (context, snapshot) {
  //                 List<DropdownMenuItem> notesitems = [];
  //                 if (!snapshot.hasData) {
  //                   CircularProgressIndicator();
  //                 } else {
  //                   final notes = snapshot.data!.docs.reversed.toList();
  //                   notesitems
  //                       .add(DropdownMenuItem(value: "0", child: Text("Sem1")));
  //                   for (var i in notes) {
  //                     notesitems.add(DropdownMenuItem(
  //                         value: i.id, child: Text(i['name'])));
  //                   }
  //                 }
  //                 return DropdownButton(
  //                     isExpanded: true,
  //                     value: sem1,
  //                     items: notesitems,
  //                     onChanged: (ivalue) {
  //                       print(ivalue);
  //                     });
  //               },
  //             ),
  //           ),
  //           Center(
  //             child: StreamBuilder<QuerySnapshot>(
  //               stream: FirebaseFirestore.instance
  //                   .collection("teacherprofile")
  //                   .snapshots(),
  //               builder: (context, snapshot) {
  //                 List<DropdownMenuItem> notesitems = [];
  //                 notesitems
  //                     .add(DropdownMenuItem(value: "0", child: Text("Sem2")));
  //                 if (!snapshot.hasData) {
  //                   CircularProgressIndicator();
  //                 } else {
  //                   final notes = snapshot.data!.docs.reversed.toList();

  //                   for (var i in notes) {
  //                     notesitems.add(DropdownMenuItem(
  //                         value: i.id,
  //                         child: Container(
  //                             padding: EdgeInsets.only(left: 40),
  //                             child: Text(i['email']))));
  //                   }
  //                 }
  //                 return DropdownButton(
  //                   isExpanded: true,
  //                   value: sem2,
  //                   items: notesitems,
  //                   onChanged: (sem2) {},
  //                 );
  //               },
  //             ),
  //           ),
  //           Center(
  //             child: StreamBuilder<QuerySnapshot>(
  //               stream: FirebaseFirestore.instance
  //                   .collection("teacherprofile")
  //                   .snapshots(),
  //               builder: (context, snapshot) {
  //                 List<DropdownMenuItem> notesitems = [];
  //                 notesitems
  //                     .add(DropdownMenuItem(value: "0", child: Text("Sem3")));
  //                 if (!snapshot.hasData) {
  //                   CircularProgressIndicator();
  //                 } else {
  //                   final notes = snapshot.data!.docs.reversed.toList();

  //                   for (var i in notes) {
  //                     notesitems.add(DropdownMenuItem(
  //                         value: i.id,
  //                         child: Container(
  //                             padding: EdgeInsets.only(left: 40),
  //                             child: Text(i['email']))));
  //                   }
  //                 }
  //                 return DropdownButton(
  //                   isExpanded: true,
  //                   value: sem3,
  //                   items: notesitems,
  //                   onChanged: (sem2) {},
  //                 );
  //               },
  //             ),
  //           ),
  //           Center(
  //             child: StreamBuilder<QuerySnapshot>(
  //               stream: FirebaseFirestore.instance
  //                   .collection("teacherprofile")
  //                   .snapshots(),
  //               builder: (context, snapshot) {
  //                 List<DropdownMenuItem> notesitems = [];
  //                 notesitems
  //                     .add(DropdownMenuItem(value: "0", child: Text("Sem4")));
  //                 if (!snapshot.hasData) {
  //                   CircularProgressIndicator();
  //                 } else {
  //                   final notes = snapshot.data!.docs.reversed.toList();

  //                   for (var i in notes) {
  //                     notesitems.add(DropdownMenuItem(
  //                         value: i.id,
  //                         child: Container(
  //                             padding: EdgeInsets.only(left: 40),
  //                             child: Text(i['email']))));
  //                   }
  //                 }
  //                 return DropdownButton(
  //                   isExpanded: true,
  //                   value: sem4,
  //                   items: notesitems,
  //                   onChanged: (sem2) {},
  //                 );
  //               },
  //             ),
  //           ),
  //           ElevatedButton(
  //               onPressed: () {
  //                 showDialog(
  //                     context: context,
  //                     builder: (context) {
  //                       return Container(
  //                           child: AlertDialog(
  //                         title: Text("Upload Document"),
  //                         actions: [
  //                           TextFormField(
  //                             controller: semController,
  //                             decoration: InputDecoration(
  //                                 suffixIcon: const Icon(Icons.numbers_rounded),
  //                                 fillColor: Colors.grey.shade100,
  //                                 filled: true,
  //                                 hintText: "Enter Semester",
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(25),
  //                                 )),
  //                           ),
  //                           TextFormField(
  //                             controller: filenamecontroller,
  //                             decoration: InputDecoration(
  //                                 suffixIcon: const Icon(Icons.numbers_rounded),
  //                                 fillColor: Colors.grey.shade100,
  //                                 filled: true,
  //                                 hintText: "Notes Name",
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(25),
  //                                 )),
  //                           ),
  //                           Center(
  //                             child: TextButton(
  //                                 onPressed: () async {
  //                                   await selectfile();
  //                                 },
  //                                 child: Text("Select File")),
  //                           ),
  //                           TextButton(
  //                             child: const Text("Upload"),
  //                             onPressed: () async {
  //                               var semselect = semController.text.trim();
  //                               var notesname = filenamecontroller.text.trim();
  //                               Reference referenceRoot =
  //                                   FirebaseStorage.instance.ref();
  //                               Reference Imagedirectory = referenceRoot
  //                                   .child("${semselect.toString()}");
  //                               Reference uplodeimage =
  //                                   Imagedirectory.child("${userid!.uid}.pdf");
  //                               try {
  //                                 await uplodeimage
  //                                     .putFile(File(pikedFile!.path!));
  //                                 final snapshot =
  //                                     await uplodeimage.getDownloadURL();
  //                                 addnotes(semselect, snapshot, notesname);
  //                               } catch (e) {}
  //                             },
  //                             // controller: phoneController,
  //                           ),
  //                         ],
  //                       ));
  //                     });
  //               },
  //               child: const Text("Upload"))







  // Card(
  //               elevation: 20,
  //               color: Color.fromARGB(255, 254, 182, 87),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //               ),
  //               child: SizedBox(
  //                 width: 300,
  //                 height: 80,
  //                 child: Center(
  //                     child: TextButton(
  //                         onPressed: () {
  //                           Get.to(() => teachersem1notes());
  //                         },
  //                         child: Text('Semester - 1',
  //                             style: TextStyle(
  //                                 fontSize: 25, color: Colors.white)))),
  //               )),
  // Text("Sem${DS["sem"]}")),