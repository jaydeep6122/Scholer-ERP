import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:scholer/Notes/Teachers/drawer.dart';
import 'package:scholer/Notes/Teachers/home.dart';
import 'package:scholer/signupservices.dart';

DateTime _dateTime = DateTime.now();

class addjob extends StatefulWidget {
  const addjob({super.key});

  @override
  State<addjob> createState() => _addjobState();
}

class _addjobState extends State<addjob> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  void _showdataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Add Job"),
            backgroundColor: Color.fromRGBO(96, 63, 131, 1)),
        //backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        focusNode: FocusNode(),
                        controller: titleController,
                        decoration: InputDecoration(
                          //suffixIcon: Icon(Icons.email),
                          fillColor: Colors.grey.shade100,
                          // filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: "Job Title",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: FocusNode(),
                        maxLines: 7,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            //suffixIcon: Icon(Icons.email),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Job Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadiusDirectional.circular(25)),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("End Date")),
                          Spacer(),
                          Text(
                              "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}"),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: IconButton(
                                onPressed: _showdataPicker,
                                icon: Icon(Icons.calendar_today)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: FocusNode(),
                        controller: linkController,
                        decoration: InputDecoration(
                            //suffixIcon: Icon(Icons.email),
                            fillColor: Colors.grey.shade100,
                            // filled: true,
                            hintText: "Job Link",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 200,
                      child: MaterialButton(
                        //splashColor: Color.fromRGBO(1, 79, 134, 20),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 50,
                        onPressed: () async {
                          var title = titleController.text.trim();
                          var description = descriptionController.text.trim();
                          var link = linkController.text.trim();
                          await jobaddtodatabase(
                              title, description, _dateTime, link);
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
                                  "Job Submited",
                                ))),
                                actions: [
                                  Center(
                                    child: TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          Get.off(() => home());
                                        },
                                        child: Text("ok")),
                                  ),
                                ],
                              ));
                            },
                          );
                        },

                        color: Color.fromRGBO(1, 79, 131, 20),
                        child: const Text(
                          "Submit",
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
    );
  }
}
