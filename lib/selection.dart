import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scholer/Notes/Teachers/teacherloginpage.dart';
import 'package:scholer/Notes/Teachers/teacherprofile.dart';
import 'package:scholer/Notes/students/loginpage.dart';
import 'package:scholer/Notes/students/studentlogin.dart';
import 'package:scholer/Notes/students/studentprofile.dart';
import 'package:scholer/signupservices.dart';

class selecton extends StatefulWidget {
  const selecton({super.key});

  @override
  State<selecton> createState() => _selectonState();
}

class _selectonState extends State<selecton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/front.jpg',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 400,
                  child: Lottie.asset("assets/selection.json"),
                ),
                const Text(
                  'Welcome to ',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "NotoSerif",
                      color: Color.fromRGBO(96, 63, 131, 1)),
                ),
                const Text(
                  'Scholer',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "NotoSerif",
                      color: Color.fromRGBO(96, 63, 131, 1)),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Are You ?',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "NotoSerif",
                      color: Color.fromARGB(255, 18, 44, 114)),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 40),
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(1, 79, 134, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text("Staff"),
                        onPressed: () {
                          Get.to(() => teacherlogin());
                          userrrrsss();
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(1, 79, 134, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text("Student"),
                        onPressed: () {
                          Get.to(() => LoginPage());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
