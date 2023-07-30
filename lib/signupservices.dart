// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:scholer/Notes/Teachers/home.dart';
import 'package:scholer/Notes/Teachers/subjectnotes.dart';
import 'package:scholer/Notes/Teachers/teachernotes.dart';
import 'package:scholer/Notes/students/studentdashbord.dart';

import 'package:scholer/Notes/Teachers/teacherprofile.dart';

int attendancee = 0;
int total = 0;
int tt = 0;
String noteuploadsubject = '';
late Stream<QuerySnapshot> streamteacherdetails;
User? userid = FirebaseAuth.instance.currentUser;

teacherprofileregister(
    String name,
    String email,
    String phone,
    String parentsphone,
    String image,
    String date,
    String lastQf,
    String uid) async {
  try {
    List<dynamic> someData = [];
    await FirebaseFirestore.instance.collection("teacherprofile").doc(uid).set({
      'name': name,
      'email': email,
      'mobile': phone,
      'parents mobile': parentsphone,
      // 'subject': FieldValue.arrayUnion(someData),
      "profile_pic": image,
      "uid": uid,
      "attendance": 0,
      "Date of Birth": date,
      "qualification": lastQf,
      "total": 0,
      "time": false
    }).then((value) => {Get.offAll(() => const home())});
    print("Data Added");
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

studentprofileregister(
    String name,
    String email,
    String phone,
    String parentsphone,
    String image,
    String date,
    String lastQf,
    String uid) async {
  try {
    await FirebaseFirestore.instance.collection("studentprofile").doc(uid).set({
      'name': name,
      'email': email,
      'mobile': phone,
      'parents mobile': parentsphone,
      "profile_pic": image,
      "uid": uid,
      "Date of Birth": date,
      "qualification": lastQf,
    }).then((value) => {Get.to(() => const studentdasshboard())});
    print("Data Added");
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

studentattendasecollection(String name, String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection("attendance_sem 1")
        .doc(uid)
        .set({
      'name': name,
      "uid": uid,
      "DS": 0,
      "OOP": 0,
      "COA": 0,
      "DM": 0,
      "TOC": 0,
      "AOP": 0,
      "DS_total": 0,
      "OOP_total": 0,
      "COA_total": 0,
      "DM_total": 0,
      "TOC_total": 0,
      "AOP_total": 0
    }).then((value) => {Get.to(() => const studentdasshboard())});
    print("Data Added");
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

attendance() async {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  attendancee++;
  await FirebaseFirestore.instance
      .collection("teacherprofile")
      .doc(user!.uid)
      .update({'attendance': attendancee}).then(
          (value) => {print("Data Update")});
}

addnotes(String sem, String notes, String notesname, String subject) async {
  try {
    var collection = await FirebaseFirestore.instance.collection(sem);
    List<dynamic> someData = [notesname, notes];
    collection
        .doc(subject) // <-- Document ID
        .update({
      'notes': FieldValue.arrayUnion(someData),
      "uid": userid!.uid,
      "subject": subject
    }).then((value) => SnackBar(
              content: const Text('Hi, I am a SnackBar!'),
              backgroundColor: (Colors.black12),
              action: SnackBarAction(
                label: 'dismiss',
                onPressed: () {},
              ),
            ));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar));
    // <-- Add data

    // collection.add({'text': 'data added through app'});
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

updatenotes(String sem, String notes, String notesname, String subject) async {
  try {
    var collection = await FirebaseFirestore.instance.collection(sem);
    List<dynamic> someData = [notesname, notes];
    collection
        .doc(subject) // <-- Document ID
        .update({
      'notes': FieldValue.arrayUnion(someData),
      "uid": userid!.uid,
      "subject": subject
    }); // <-- Add data

    // collection.add({'text': 'data added through app'});
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

removenotes(String sem, String notes, String notesname, String subject) async {
  try {
    var collection = await FirebaseFirestore.instance.collection(sem);
    List<dynamic> someData = [notesname, notes];
    collection
        .doc(subject) // <-- Document ID
        .update({
      'notes': FieldValue.arrayRemove(someData),
      "uid": userid!.uid,
      "subject": subject
    }); // <-- Add data

    // collection.add({'text': 'data added through app'});
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

changetotal() async {
  var collection = FirebaseFirestore.instance.collection("teacherprofile");
  var querySnapshots = await collection.get();
  for (var doc in querySnapshots.docs) {
    await doc.reference.update({
      "total": total + 1,
    });
  }
}

addstudentattendance(
    String sem, String subjectselect, List array, List attendancenumber) async {
  var collection = FirebaseFirestore.instance.collection(sem);
  var querySnapshots = await collection.get();
  for (var doc in querySnapshots.docs) {
    await doc.reference.update({
      "${subjectselect}_total": tt + 1,
    });
  }

  for (var i = 0; i < array.length; i++) {
    FirebaseFirestore.instance.collection(sem).doc(array[i]).update({
      "$subjectselect": attendancenumber[i] + 1,
    });
  }
}

teacherfeedbacksubmit(String feedback) async {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("feedback").doc(user!.uid).set(
        {"Feed_back": feedback}).then((value) => {Get.to(() => const home())});
    print("Feedback Submited");
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

studentfeedbacksubmit(String feedback) async {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance
        .collection("feedback")
        .doc(user!.uid)
        .set({"Feed_back": feedback}).then(
            (value) => {Get.to(() => const studentdasshboard())});
    print("Feedback Submited");
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

attendancetimechange() async {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance
        .collection("teacherprofile")
        .doc(user!.uid)
        .update({"time": false});
    //print("Feedback Submited");
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

timechageforeveryone() async {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  try {
    var collection = FirebaseFirestore.instance.collection("teacherprofile");
    var querySnapshots = await collection.get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        "time": true,
      });
    }
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

jobaddtodatabase(
    String title, String description, DateTime date, String link) async {
  try {
    var collection = await FirebaseFirestore.instance.collection("jobs");
    List<dynamic> someData = [title, description, date, link];
    collection
        .doc(title) // <-- Document ID
        .set({
      'title': title,
      'description': description,
      'date': date,
      'link': link
    });
  } on FirebaseAuthException catch (e) {
    print("Error");
  }
}

userrrrsss() {
  User? user;
  user = FirebaseAuth.instance.currentUser;
  print(user);
}
