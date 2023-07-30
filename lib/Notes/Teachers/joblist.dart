import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'drawer.dart';

class joblist extends StatefulWidget {
  const joblist({super.key});

  @override
  State<joblist> createState() => _joblistState();
}

class _joblistState extends State<joblist> {
  List<String> jobarry = [];
  bool opendropdown = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 63, 131, 1),
          title: Text("Job List"),
        ),
        endDrawer: drawer(),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("jobs")
                //.where("subject", isEqualTo: "${widget.subjectselect}")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot != null && snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var jobs = snapshot.data!.docs[index];

                      return Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              //for (var i = 0; i < count; i = i + 2)
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 197, 196, 196)),
                                    color: Color.fromRGBO(202, 213, 213, 1)),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "${jobs["title"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.open_in_browser)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.update))
                                  ],
                                ),
                              ),
                              // opendropdown
                              //     ? Row(
                              //         children: [
                              //           IconButton(
                              //               onPressed: () {},
                              //               icon: Icon(Icons.open_in_browser)),
                              //           IconButton(
                              //               onPressed: () {},
                              //               icon: Icon(Icons.delete)),
                              //           IconButton(
                              //               onPressed: () {},
                              //               icon: Icon(Icons.update))
                              //         ],
                              //       )
                              //     : Container()
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
    ;
  }
}
 // Text Button
                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(40)),
                              //   height: 50,
                              //   child: ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       primary: Color.fromRGBO(1, 79, 134, 20),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(10)),
                              //     ),
                              //     onPressed: () {},
                              //     child: Text(
                              //       "Upload Notes",
                              //       style: TextStyle(fontSize: 15),
                              //     ),
                              //   ),
                              // ),

                              // if (jobarry.contains("${jobs["title"]}")) {
                              //       jobarry.remove("${jobs["title"]}");
                              //       setState(() {
                              //         opendropdown = false;
                              //       });
                              //     } else {
                              //       jobarry.add("${jobs["title"]}");
                              //       setState(() {
                              //         opendropdown = true;
                              //       });
                              //     }
                              //     print(jobarry.toString());