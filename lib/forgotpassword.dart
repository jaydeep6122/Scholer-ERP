import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'package:scholer/selection.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  TextEditingController forgotpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/front.jpg',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              child: Text(
                'Scholer',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: "NotoSerif",
                    color: Color.fromARGB(255, 18, 44, 114)),
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.14),
              child: Image(image: AssetImage("assets/logo.png")),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        controller: forgotpasswordcontroller,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150,
                      child: MaterialButton(
                        //splashColor: Color.fromRGBO(1, 79, 134, 20),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 50,
                        onPressed: () async {
                          var forgotemail =
                              forgotpasswordcontroller.text.trim();
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: forgotemail);
                            Get.off(selecton());
                          } on FirebaseAuth catch (e) {
                            print("Error : $e");
                          }
                          //Get.to(() => MyLogin());
                        },
                        color: Color.fromRGBO(1, 79, 131, 20),
                        child: const Text(
                          "Reset",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
// var forgotemail =
//                                   forgotpasswordcontroller.text.trim();
//                               try {
//                                 await FirebaseAuth.instance
//                                     .sendPasswordResetEmail(email: forgotemail);
//                                 Get.off(MyLogin());
//                               } on FirebaseAuth catch (e) {
//                                 print("Error : $e");
//                               }
//                               Get.to(() => MyLogin());