import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/home.dart';
import 'package:scholer/Notes/Teachers/teacherprofile.dart';
import 'package:scholer/Notes/students/studentdashbord.dart';
import 'package:scholer/forgotpassword.dart';
import 'package:scholer/signupservices.dart';

class teacherlogin extends StatefulWidget {
  @override
  _teacherloginState createState() => _teacherloginState();
}

class _teacherloginState extends State<teacherlogin> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //final _auth = FirebaseAuth.instance;
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                //color: Colors.orangeAccent[700],

                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height * 0.70,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.14),
                            child: const Image(
                                image: AssetImage("assets/logo.png")),
                          ),
                          const Text(
                            'Scholer',
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "NotoSerif",
                                color: Color.fromRGBO(96, 63, 131, 1)),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.email),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isObscure3,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure3
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure3 = !_isObscure3;
                                    });
                                  }),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              enabled: true,
                            ),
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: TextButton(
                                    onPressed: () {
                                      Get.to(() => forgotpassword());
                                    },
                                    child: Text(
                                      "Forgot Password ? ",
                                      style: TextStyle(
                                          color: Color.fromRGBO(1, 79, 131, 20),
                                          decoration: TextDecoration.underline),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            // color: Color.fromRGBO(1, 79, 131, 20),
                            width: 200,
                            child: MaterialButton(
                              //splashColor: Color.fromRGBO(1, 79, 134, 20),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 50,
                              onPressed: () {
                                setState(() {
                                  visible = true;
                                });
                                //var email = emailController.text;
                                signIn(emailController.text.trim(),
                                    passwordController.text.trim());
                              },
                              color: Color.fromRGBO(1, 79, 131, 20),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: visible,
                              child: Container(
                                  child: const CircularProgressIndicator(
                                color: Colors.white,
                              ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Center(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('teacherprofile')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => home(),
            ));
      } else {
        FirebaseFirestore.instance
            .collection('studentprofile')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            print("You Are Not Staff Please Login With Student");
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                    child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Center(
                      child: Center(
                          child: Text(
                    "You Are Not Staff Please Login With Student",
                  ))),
                  actions: [
                    Center(
                      child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text("ok")),
                    ),
                  ],
                ));
              },
            );
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => home(),
            //     ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => teacherprofile(),
                ));
          }
        });
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          showDialog(
            context: context,
            builder: (context) {
              return Container(
                  child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Center(
                    child: Center(
                        child: Text(
                  "You Are not a Teacher or Staff please Contact to admin office",
                ))),
                actions: [
                  Center(
                    child: TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text("ok")),
                  ),
                ],
              ));
            },
          );
        } else if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) {
              return Container(
                  child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Center(
                    child: Center(
                        child: Text(
                  "Wrong Password Please Enter Valid password",
                ))),
                actions: [
                  Center(
                    child: TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text("ok")),
                  ),
                ],
              ));
            },
          );
        }
      }
    }
  }
}
