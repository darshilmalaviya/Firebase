// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreenRegister extends StatefulWidget {
  const HomeScreenRegister({Key? key, this.uid}) : super(key: key);

  final uid;

  @override
  State<HomeScreenRegister> createState() => _HomeScreenRegisterState();
}

class _HomeScreenRegisterState extends State<HomeScreenRegister> {
  CollectionReference Users = FirebaseFirestore.instance.collection('users');
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  File? image;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {},
        ),
        body: FutureBuilder(
          future: Users.doc(widget.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            maxRadius: 50,
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
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 100);

                                  image = File(file!.path);
                                  print('PATHH ${file.path}');
                                  setState(() {});
                                }
                              },
                              child: data['Profile'] == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: FileImage(image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: image == null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                  data['Profile']!,
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                            : DecorationImage(
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        'First Name : ${data['First name']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Last Name : ${data['Last name']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Gender : ${data['Gender']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Email : ${data['Email']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            firstName.text = data['First name'];
                            lastName.text = data['Last name'];
                            gender.text = data['Gender'];
                            email.text = data['Email'];

                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: SizedBox(
                                        height: 300,
                                        width: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: firstName,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Email",
                                                ),
                                              ),
                                              TextField(
                                                controller: lastName,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Name",
                                                ),
                                              ),
                                              TextField(
                                                controller: gender,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Numbers",
                                                ),
                                              ),
                                              TextField(
                                                controller: email,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Numbers",
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: MaterialButton(
                                                    height: 50,
                                                    color: Colors.blue,
                                                    onPressed: () async {
                                                      await storage
                                                          .ref(
                                                              "profile/${widget.uid}.png")
                                                          .putFile(image!)
                                                          .then(
                                                        (p0) async {
                                                          String url = await p0
                                                              .ref
                                                              .getDownloadURL();

                                                          await Users.doc(
                                                                  "${widget.uid}")
                                                              .update(
                                                            {
                                                              "First name":
                                                                  firstName
                                                                      .text,
                                                              "Last name":
                                                                  lastName.text,
                                                              "Gender":
                                                                  gender.text,
                                                              "Email":
                                                                  email.text,
                                                              "Profile": url
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: const Text("Update"),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },
                          child: const Text("Update")),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
