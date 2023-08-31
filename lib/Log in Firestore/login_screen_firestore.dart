// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase/Log%20in%20Firestore/register_screen_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Log_In/bottom_nav_bar.dart';
import '../Log_In/home_screen.dart';
import 'home_screen.dart';

class LoginScreenFirestore extends StatefulWidget {
  const LoginScreenFirestore({Key? key}) : super(key: key);

  @override
  State<LoginScreenFirestore> createState() => _LoginScreenFirestoreState();
}

TextEditingController emailcntrl = TextEditingController();
TextEditingController passcntrl = TextEditingController();

bool loading = false;

class _LoginScreenFirestoreState extends State<LoginScreenFirestore> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var show = false;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login Screen",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextFormField(
                    controller: emailcntrl,
                    // validator: (value) {
                    //   bool validEmail = RegExp(
                    //           "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                    //       .hasMatch(value!);
                    //   if (validEmail) {
                    //     return null;
                    //   } else {
                    //     return "Invalid Email";
                    //   }
                    // },
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
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: passcntrl,
                    // validator: (value) {
                    //   bool validPass = RegExp(
                    //           "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$")
                    //       .hasMatch(value!);
                    //   if (validPass) {
                    //     return null;
                    //   } else {
                    //     return "Invalid Password";
                    //   }
                    // },
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
                SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Text('Forget password ?')),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an account ?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Firstname.clear();
                          Lastname.clear();
                          emailcntrl.clear();
                          passcntrl.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterScreenFirestore(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
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
                if (loading)
                  const CircularProgressIndicator()
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () async {
                          // if (formkey.currentState!.validate()) {

                          setState(() {
                            loading = true;
                          });
                          try {
                            UserCredential userCredential =
                                await auth.signInWithEmailAndPassword(
                                    email: emailcntrl.text,
                                    password: passcntrl.text);

                            /// await auth.sendPasswordResetEmail(email: emailcntrl.text);

                            if (kDebugMode) {
                              print("USER ID ${userCredential.user!.uid}");
                            }
                            setState(() {
                              loading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Succesfully"),
                              ),
                            );

                            log('iddddddddddd---->${userCredential.user!.uid}');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Bottommoney(
                            //           userid: userCredential.user!.uid),
                            //     ));
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${e.message}"),
                              ),
                            );
                          }
                        }
                        // },
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
