import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/drawer.dart';
import 'package:scholer/Notes/Teachers/home.dart';
import 'package:scholer/Notes/Teachers/teachernotes.dart';
import 'package:scholer/Notes/students/studentdashbord.dart';
import 'package:scholer/forgotpassword.dart';
import 'package:scholer/signupservices.dart';

class studentlogin extends StatefulWidget {
  const studentlogin({super.key});

  @override
  State<studentlogin> createState() => _studentloginState();
}

class _studentloginState extends State<studentlogin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _obscureText = true;
  bool teacher = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/bg9.jpg',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              // ignore: sort_child_properties_last
              child: const Text(
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
              child: const Image(image: AssetImage("assets/logo.png")),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.email),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: passwordcontroller,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        Container(
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 18, 44, 114)),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 120)),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              const Color.fromARGB(255, 11, 42, 110),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              var email = emailcontroller.text.trim();
                              var password = passwordcontroller.text.trim();
                              try {
                                //await clickdone(email);
                              } catch (e) {
                                print("Error : $e");
                              }
                              // Navigator.pushNamed(context, "home");
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 150)),
                        TextButton(
                            onPressed: () {
                              Get.to(const forgotpassword());
                            },
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 17, 73, 193)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
