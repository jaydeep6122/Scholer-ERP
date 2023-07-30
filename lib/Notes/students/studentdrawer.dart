import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/students/studentattendancesem1.dart';
import 'package:scholer/Notes/students/studentfeedback.dart';
import 'package:scholer/Notes/students/studentnotes.dart';

import 'package:scholer/Notes/students/studentdashbord.dart';

import 'package:scholer/selection.dart';

TextEditingController attendanceController = TextEditingController();

Drawer studentdrawer(bool isbuttonisactive) {
  User? user = FirebaseAuth.instance.currentUser;
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                height: 130,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("studentprofile")
                      .where("uid", isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    // ignore: unnecessary_null_comparison
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(name),
                                ],
                              ),
                            );
                          });
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Dashboard"),
          onTap: () {
            Get.to(() => const studentdasshboard());
          },
        ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text("Attendance"),
          onTap: () {
            Get.to(() => studentattendancesem1());
          },
        ),

        ListTile(
          leading: const Icon(Icons.book),
          title: const Text("Notes"),
          onTap: () {
            //Get.to(() => teachernotes());
            Get.to(() => const studentsnotes());
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.book),
        //   title: Text("Assignment Submition"),
        //   onTap: () {
        //     Get.to(() => studentdasshboard());
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.feedback),
          title: const Text("Feedback"),
          onTap: () {
            //getlocation();
            //getDataOnce_multipleDocumentsFromACollection();
            Get.to(() => const studentfeedback());
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("logout"),
          onTap: () async {
            await FirebaseAuth.instance
                .signOut()
                .then((value) => Get.offAll(() => const selecton()));
          },
        )
      ],
    ),
  );
}
