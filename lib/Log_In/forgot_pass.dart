import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForggotPass extends StatefulWidget {
  const ForggotPass({super.key, this.emialcntrl});
  final emialcntrl;

  @override
  State<ForggotPass> createState() => _ForggotPassState();
}

class _ForggotPassState extends State<ForggotPass> {
  FirebaseAuth Auth = FirebaseAuth.instance;
  TextEditingController emailcntrl = TextEditingController();

  Future getData() async {}

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emailcntrl.text = widget.emialcntrl;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text("Forgot Password",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
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
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () async {
                    await Auth.sendPasswordResetEmail(email: emailcntrl.text);
                  },
                  child: Text("Send Email"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
