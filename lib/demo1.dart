// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterScreenFirestore extends StatefulWidget {
  const RegisterScreenFirestore({Key? key}) : super(key: key);

  @override
  State<RegisterScreenFirestore> createState() =>
      _RegisterScreenFirestoreState();
}

class _RegisterScreenFirestoreState extends State<RegisterScreenFirestore> {
  CollectionReference Users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  var show = false;
  final formkey = GlobalKey<FormState>();

  String? selectedGender;
  TextEditingController Firstname = TextEditingController();
  TextEditingController Lastname = TextEditingController();
  TextEditingController emailcntrl = TextEditingController();
  TextEditingController passcntrl = TextEditingController();

  Future getdata() async {
    await Users.add(
      {
        "First Name": Firstname.text,
        "Last Name": Lastname.text,
        "Gender": selectedGender,
        "Email": emailcntrl.text,
        "Password": passcntrl.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.005),
                      child: const Text(
                        "Register Screen",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
                    child: TextFormField(
                      controller: Firstname,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "First name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.03),
                    child: TextFormField(
                      controller: Lastname,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Last name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  RadioListTile(
                    title: const Text('Male'),
                    value: 'male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(
                        () {
                          selectedGender = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile(
                    title: const Text('Female'),
                    value: 'female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: TextFormField(
                      controller: emailcntrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.03),
                    child: TextFormField(
                      controller: passcntrl,
                      validator: (value) {
                        bool validPass = RegExp(
                                "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$")
                            .hasMatch(value!);
                        if (validPass) {
                          return null;
                        } else {
                          return "Invalid Password";
                        }
                      },
                      obscureText: show,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {});
                              show = !show;
                            },
                            icon: show == true
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.04),
                      child: ElevatedButton(
                        child: const Text('Register'),
                        onPressed: () async {
                          try {
                            UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                              email: emailcntrl.text,
                              password: passcntrl.text,
                            );
                            if (kDebugMode) {
                              print("USER ID ${userCredential.user!.uid}");
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Register Succesfully"),
                              ),
                            );
                            getdata();

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => HomeScreen(
                            //         uid: userCredential.user!.uid),
                            //   ),
                            // );
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${e.message}"),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
