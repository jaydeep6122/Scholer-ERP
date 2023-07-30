import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

import 'package:scholer/signupservices.dart';

class studentsnotes extends StatefulWidget {
  const studentsnotes({super.key});

  @override
  State<studentsnotes> createState() => _studentsnotesState();
}

class _studentsnotesState extends State<studentsnotes> {
  String sem1 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("teacherprofile")
              .where("uid", isEqualTo: userid!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var name = snapshot.data!.docs[index];

                    //var ql = snapshot.data!.docs[index]["last qualification"];

                    return Center(
                      child: Column(
                        children: [
                          Text(name.toString()),
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
    );
  }
}




//  _progress != null
//                                 ? CircularProgressIndicator()
//                                 : ElevatedButton(
//                                     onPressed: () {
//                                       FileDownloader.downloadFile(
//                                           url: lq.toString(),
//                                           onProgress: (name, progress) {
//                                             setState(() {
//                                               _progress = progress;
//                                             });
//                                           },
//                                           onDownloadCompleted: (value) {
//                                             print("Path $value");
//                                             setState(() {
//                                               _progress = null;
//                                             });
//                                           });
//                                     },
//                                     child: Text("Download file"))


// StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('1') // 👈 Your desired collection name here
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text("Loading");
//             }
            // return ListView(
            //     children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //   Map<String, dynamic> data =
            //       document.data()! as Map<String, dynamic>;
            //   return DropdownButton(
            //   isExpanded: true,
            //   //value: sem1,
            //   items: notesitems,
            //   onChanged: (sem2) {},
            // );
            // }).toList());
//           },
// //         ),