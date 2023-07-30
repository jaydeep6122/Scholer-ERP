import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/home.dart';
import 'package:scholer/Notes/students/studentdashbord.dart';
import 'package:scholer/selection.dart';
import 'package:scholer/signupservices.dart';

void main() async {
  //Timer.periodic for repiting time in duration
  const oneSec = Duration(days: 1);
  Timer.periodic(oneSec, (Timer t) => changetotal());
  //timechage for all teacher attendance
  const day = Duration(days: 1);
  Timer.periodic(day, (Timer t) => timechageforeveryone());
  //initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool jd = true;
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    setState(() {
      jd;
    });
  }

  @override
  Widget build(BuildContext context) {
    // to check user is login or not after reload
    // If already login Move on Dashboard
    user != null
        ? FirebaseFirestore.instance
            .collection('teacherprofile')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              setState(() {
                jd = true;
              });
            } else {
              FirebaseFirestore.instance
                  .collection('studentprofile')
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  setState(() {
                    jd = false;
                  });
                }
              });
            }
          })
        : const selecton();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null
          ? jd
              ? home()
              : studentdasshboard()
          : selecton(),
    );
  }
}
