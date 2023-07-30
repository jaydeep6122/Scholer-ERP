import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:scholer/signupservices.dart';

class studentprofile extends StatefulWidget {
  const studentprofile({super.key});

  @override
  State<studentprofile> createState() => _studentprofileState();
}

class _studentprofileState extends State<studentprofile> {
  User? user;
  String imageurl = '';
  String image = '';
  String lastQL = '';
  PlatformFile? pikedFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController parentsController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;
    setState(() {
      pikedFile = result.files.first;
      lastQL;
    });
  }

  void _showdataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime(2005),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        image = imageurl;
      });
    });
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: const Text(
                'Student Profile Registation Form',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "NotoSerif",
                    color: Color.fromARGB(255, 18, 44, 114)),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Full Name",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Personal Email",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Mobile Number",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          // maxLength: 10,
                          controller: parentsController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Parents Mobile Number",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextButton(
                            onPressed: _showdataPicker,
                            child: Text("Select Your DOB")),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        child: TextButton(
                          child: const Text("Upload Profile Picture"),
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            print("${file?.path}");
                            if (file == null) return;
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference Imagedirectory =
                                referenceRoot.child("Profilepic");
                            Reference uplodeimage =
                                Imagedirectory.child(user!.uid);

                            try {
                              await uplodeimage.putFile(File(file.path));
                              imageurl = await uplodeimage.getDownloadURL();
                              print(image);
                            } catch (e) {}
                          },
                          // controller: phoneController,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: TextButton(
                          child: const Text(
                              "Upload Last Qualification Certificate"),
                          onPressed: () async {
                            await selectfile();
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference Imagedirectory =
                                referenceRoot.child("StudentQualification");
                            Reference uplodeimage =
                                Imagedirectory.child(user!.uid);
                            try {
                              await uplodeimage.putFile(File(pikedFile!.path!));
                              final snapshot =
                                  await uplodeimage.getDownloadURL();
                              lastQL = snapshot;
                            } catch (e) {}
                          },
                          // controller: phoneController,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            child: const Text(
                              'Submit',
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
                                var email = emailController.text.trim();
                                var name = nameController.text.trim();
                                var phone = phoneController.text.trim();
                                var parentsphone =
                                    parentsController.text.trim();

                                var image = imageurl;
                                await studentprofileregister(
                                    name,
                                    email,
                                    phone,
                                    parentsphone,
                                    image,
                                    _dateTime.toString(),
                                    lastQL,
                                    user!.uid);

                                //Get.to(() => const home2());
                                studentattendasecollection(name, user!.uid);
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
