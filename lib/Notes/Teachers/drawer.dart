import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/addjob.dart';
import 'package:scholer/Notes/Teachers/attendance.dart';
import 'package:scholer/Notes/Teachers/feedback.dart';

import 'package:scholer/Notes/Teachers/teachernotes.dart';
import 'package:scholer/selection.dart';

import 'home.dart';
import 'joblist.dart';

TextEditingController attendanceController = TextEditingController();

Drawer drawer() {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  return Drawer(
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
              style: TextStyle(color: Colors.red),
            )),
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
  );
}

// getdoc() async {
//   final docRef = FirebaseFirestore.instance
//       .collection("sem 1")
//       .where("uid", isEqualTo: userid!.uid)
//       .count();
//   docRef.get().then((res) => print("${res.count}" + "$docRef"));
// }
