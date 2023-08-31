// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'bottom_nav_bar.dart';

class RegisterScreenImage extends StatefulWidget {
  const RegisterScreenImage({Key? key}) : super(key: key);

  @override
  State<RegisterScreenImage> createState() => _RegisterScreenImageState();
}

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference Users = FirebaseFirestore.instance.collection('users');
TextEditingController Firstname = TextEditingController();
TextEditingController Lastname = TextEditingController();
TextEditingController emailcntrl = TextEditingController();
TextEditingController passcntrl = TextEditingController();

class _RegisterScreenImageState extends State<RegisterScreenImage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var show = false;
  final formkey = GlobalKey<FormState>();

  String? selectedGender;
  File? image;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Users.get(),
          builder: (context, snapshot) {
            return Form(
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
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.05, bottom: height * 0.05),
                          child: const Text(
                            "Register Screen",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (image == null) {
                              XFile? file = await imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 100);

                              image = File(file!.path);
                              print('PATHH ${file.path}');
                              setState(() {});
                            } else {
                              image = null;
                              setState(() {});
                            }
                          },
                          child: CircleAvatar(
                            maxRadius: 50,
                            child: image == null
                                ? const Icon(Icons.image, size: 40)
                                : Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: FileImage(
                                          image!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
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
                          setState(() {
                            selectedGender = value!;
                          });
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
                      RadioListTile(
                        title: const Text('Other'),
                        value: 'other',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(
                            () {
                              selectedGender = value!;
                            },
                          );
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Sign in",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
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
                                await storage
                                    .ref(
                                        "profile/${userCredential.user!.uid}.png")
                                    .putFile(image!)
                                    .then(
                                  (p0) async {
                                    String url = await p0.ref.getDownloadURL();

                                    print('URL ${url}');
                                    await Users.doc(userCredential.user!.uid)
                                        .set(
                                      {
                                        "Profile": url,
                                        "First name": Firstname.text,
                                        "Last name": Lastname.text,
                                        "Gender": selectedGender,
                                        "Email": emailcntrl.text,
                                        "Password": passcntrl.text,
                                      },
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavRegister(
                                            userid: userCredential.user!.uid),
                                      ),
                                    );
                                  },
                                );
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
            );
          },
        ),
      ),
    );
  }
}
