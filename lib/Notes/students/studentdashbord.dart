import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scholer/Notes/Teachers/drawer.dart';
import 'package:scholer/Notes/students/studentdrawer.dart';

import 'package:scholer/signupservices.dart';

class studentdasshboard extends StatefulWidget {
  const studentdasshboard({super.key});

  @override
  State<studentdasshboard> createState() => _studentdasshboardState();
}

class _studentdasshboardState extends State<studentdasshboard> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Container(
        child: Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.notifications_none),
        title: Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(96, 63, 131, 1),
      ),
      endDrawer: studentdrawer(true),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("studentprofile")
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
                    var email = snapshot.data!.docs[index]["email"];
                    //var phone = snapshot.data!.docs[index]["auid"];
                    var image = snapshot.data!.docs[index]["profile_pic"];
                    var lq = snapshot.data!.docs[index]["qualification"];
                    //int attend = snapshot.data!.docs[index]["attendance"];
                    var phone = snapshot.data!.docs[index]["mobile"];

                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 35, fontFamily: "GreatVibes"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  spreadRadius: 5,
                                  offset: Offset(5, 5),
                                  blurRadius: 10,
                                  color: Colors.grey)
                            ]),
                            child: Image.network(
                              image,
                              height: 200,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            name.toString(),
                            style: TextStyle(
                                fontSize: 22, fontFamily: "Courgette"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            email.toString(),
                            style:
                                TextStyle(fontSize: 22, fontFamily: "Ysabeau"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            phone.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          Container(
                              height: 350,
                              width: 300,
                              child: Lottie.asset("assets/dashboard.json"))
                        ],
                      ),
                    );
                  });
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ));
  }
}
