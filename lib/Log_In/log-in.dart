// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Log_In/register.dart';
import 'package:firebase/Login_Screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Bottom_Bar_Data/bottom_nav_bar.dart';
import 'bottom_nav_bar.dart';
import 'forgot_pass.dart';
import 'home_screen.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

TextEditingController emailcntrl = TextEditingController();
TextEditingController passcntrl = TextEditingController();

bool loading = false;
bool user = false;

class _LoginScreen1State extends State<LoginScreen1> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference Users = FirebaseFirestore.instance.collection('user');

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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ForggotPass(emialcntrl: emailcntrl.text),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password ?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen1(),
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
                        setState(() {
                          loading = true;
                          user = true;
                        });
                        try {
                          UserCredential userCredential =
                              await auth.signInWithEmailAndPassword(
                                  email: emailcntrl.text,
                                  password: passcntrl.text);
                          if (kDebugMode) {
                            print("USER ID ${userCredential.user!.uid}");
                          }

                          var getuser =
                              await Users.doc('${userCredential.user!.uid}')
                                  .get();

                          Map<String, dynamic> currentuser =
                              getuser.data() as Map<String, dynamic>;

                          print("Current user -----------------${currentuser}");

                          if (currentuser['User'] == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "User Alredy log in to another divice"),
                              ),
                            );
                            setState(
                              () {
                                loading = false;
                              },
                            );
                          } else {
                            await Users.doc(userCredential.user!.uid).update(
                              {
                                "User": user,
                              },
                            );

                            setState(
                              () {
                                loading = false;
                              },
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Succesfully"),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreenRegister1(
                                    uid: userCredential.user!.uid),
                              ),
                            );
                          }
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
                      },
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
