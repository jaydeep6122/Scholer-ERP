import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scholer/signupservices.dart';

class feedback extends StatelessWidget {
  const feedback({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController =
        new TextEditingController();
    return Container(
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
                        focusNode: FocusNode(),
                        maxLines: 9,
                        controller: feedbackController,
                        decoration: InputDecoration(
                            //suffixIcon: Icon(Icons.email),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Give Your Feedback Here",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                          //Get.to(() => MyLogin());
                          await teacherfeedbacksubmit(
                              feedbackController.text.trim().toString());
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
                                  "Feedback Submitted",
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
                        },

                        color: Color.fromRGBO(1, 79, 131, 20),
                        child: const Text(
                          "Submit Feedback",
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
