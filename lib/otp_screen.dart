import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen(
      {Key? key,
      required this.number,
      required this.code,
      this.verficationId,
      this.forcetoken})
      : super(key: key);

  final number;
  final code;
  final forcetoken;
  final verficationId;
  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController pinputController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  int second = 30;

  bool loading = false;
  bool resend = false;
  void timepick() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            second--;

            if (second == 0) {
              timer.cancel();
              second = 30;
              resend = true;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    timepick();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Enter Code",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Enter the 6-digit verification sent to",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.number}",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Pinput(
                  controller: pinputController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(left: 3, right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
              ),
              resend
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            second = 30;
                            resend = false;
                          });
                          timepick();

                          await auth.verifyPhoneNumber(
                            phoneNumber: ' ${widget.number}',
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
                            codeSent: (verificationId, forceResendingToken) {
                              setState(() {
                                loading = false;
                              });
                            },
                            codeAutoRetrievalTimeout: (verificationId) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("REQUEST TIME OUT")));
                            },
                          );
                        },
                        child: Text("Resend",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 18)),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Resend code in ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "$second",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            " Second",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: GestureDetector(
                        onTap: () async {
                          setState(
                            () {
                              loading = true;
                            },
                          );
                          print(pinputController.text);
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: widget.verficationId,
                              smsCode: "${pinputController.text}",
                            );
                            UserCredential userCredential =
                                await auth.signInWithCredential(credential);

                            print('DATA ${userCredential.user!.uid}');
                            print('DATA ${userCredential.user!.phoneNumber}');
                            setState(
                              () {
                                loading = false;
                              },
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("success")));
                          } on FirebaseAuthException catch (e) {
                            setState(
                              () {
                                loading = false;
                              },
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${e.message}"),
                              ),
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
                              "CONTINUE",
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
    );
  }
}
