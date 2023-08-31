// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var show = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailcntrl = TextEditingController();
  TextEditingController passcntrl = TextEditingController();
  TextEditingController confirmpasscntrl = TextEditingController();

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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.2),
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
                      controller: emailcntrl,
                      // validator: (value) {
                      //   bool validEmail = RegExp(
                      //           "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
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
                    padding: EdgeInsets.only(top: height * 0.03),
                    child: TextFormField(
                      controller: confirmpasscntrl,
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
                        labelText: "Confirm password",
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
                      children: const [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.orange),
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
                          // if (formkey.currentState!.validate()) {
                          try {
                            UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                                    email: emailcntrl.text,
                                    password: passcntrl.text);

                            if (kDebugMode) {
                              print("USER ID ${userCredential.user!.uid}");
                            }

                            if (passcntrl.text == confirmpasscntrl.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Register Succesfully"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Password doesn't match"),
                                ),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${e.message}"),
                              ),
                            );
                          }
                          // }
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
