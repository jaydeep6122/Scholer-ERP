import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scholer/Notes/Teachers/subjectnotes.dart';
import 'package:scholer/Notes/Teachers/teachersem1.dart';
import 'package:scholer/Notes/students/studentdrawer.dart';
import 'package:scholer/Notes/students/studentsubjectnotes.dart';

import '../../signupservices.dart';

class studentsubject extends StatelessWidget {
  var semester = '';
  studentsubject(this.semester);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 63, 131, 1),
          title: Text("semester-${semester} Notes"),
        ),
        endDrawer: studentdrawer(false),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("$semester")
                // .where("uid", isEqualTo: userid!.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot != null && snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var subject = snapshot.data!.docs[index];

                      // for (var i in subject) {
                      //   count++;
                      // }
                      return Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => studentsubjectnotes(
                                      "${subject["subject"]}", semester)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 25,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                color: Color.fromRGBO(202, 213, 213, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(178, 193, 193, 1),
                                  width: 3,
                                )),
                            child: Column(
                              children: [
                                // for (var i = 0; i < count; i++)

                                Container(
                                  height: 120,
                                  width: 200,
                                  child: Lottie.asset("assets/subject.json"),
                                ),
                                Text(
                                  "${subject["subject"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      fontFamily: "Ysabeau"),
                                ),
                              ],
                            ),
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
// TextButton(
//                                 onPressed: () {
//                                   Get.to(() => studentsubjectnotes(
//                                       "${subject["subject"]}", semester));
//                                 },
//                                 child: Text("${subject["subject"]}")),