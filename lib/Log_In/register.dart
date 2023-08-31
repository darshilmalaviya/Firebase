import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({Key? key}) : super(key: key);

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  CollectionReference Users = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;
  var show = false;
  final formkey = GlobalKey<FormState>();
  bool loading = false;
  String countryCode = "91";
  String countryCodeIMage = "IN";

  TextEditingController namecntrl = TextEditingController();
  TextEditingController emailcntrl = TextEditingController();
  TextEditingController passcntrl = TextEditingController();
  TextEditingController confirmpasscntrl = TextEditingController();
  TextEditingController numberctnrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Registration",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: TextFormField(
                    controller: namecntrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Name",
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
                  child: TextField(
                    controller: numberctnrl,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "Number Phone",
                      prefix: SizedBox(
                        height: 20,
                        width: 75,
                        child: GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                if (kDebugMode) {
                                  print('Select country: ${country.phoneCode}');
                                }
                                countryCode = country.phoneCode;
                                countryCodeIMage = country.countryCode;
                                if (kDebugMode) {
                                  print('Select country: $countryCodeIMage');
                                }
                                setState(() {});
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Flag.fromString(countryCodeIMage,
                                    height: 15, width: 30, fit: BoxFit.contain),
                                Text("+$countryCode"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
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
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: TextFormField(
                    controller: confirmpasscntrl,
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
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: GestureDetector(
                          onTap: () async {
                            try {
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
                            setState(() {
                              loading = true;
                            });
                            if (numberctnrl.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Number Can't Be Null"),
                                ),
                              );
                            } else {
                              await auth.verifyPhoneNumber(
                                phoneNumber:
                                    '+$countryCode ${numberctnrl.text}',
                                verificationCompleted: (phoneAuthCredential) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (kDebugMode) {
                                    print('DONE');
                                  }
                                },
                                verificationFailed: (error) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("ERROR")));
                                },
                                codeSent: (verificationId,
                                    forceResendingToken) async {
                                  setState(() {
                                    loading = false;
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Otpscreen1(
                                        email: emailcntrl.text,
                                        password: passcntrl.text,
                                        namecntrl: namecntrl.text,
                                        number:
                                            '+$countryCode ${numberctnrl.text}',
                                        code: countryCode,
                                        verficationId: verificationId,
                                        forcetoken: forceResendingToken,
                                      ),
                                    ),
                                  );
                                },
                                codeAutoRetrievalTimeout: (verificationId) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("REQUEST TIME OUT")));
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 70,
                            width: 350,
                            decoration: BoxDecoration(
                              color: const Color(0xffffb847c),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "SEND VIA SMS",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
