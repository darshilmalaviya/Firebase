// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreenRegister1 extends StatefulWidget {
  const HomeScreenRegister1({Key? key, this.uid}) : super(key: key);

  final uid;

  @override
  State<HomeScreenRegister1> createState() => _HomeScreenRegister1State();
}

class _HomeScreenRegister1State extends State<HomeScreenRegister1> {
  CollectionReference Users = FirebaseFirestore.instance.collection('user');
  File? image;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  // TextEditingController firstName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  // TextEditingController gender = TextEditingController();
  // TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Users.doc('${widget.uid}').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (image == null) {
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          image = File(file!.path);
                          print('PATHH ${file.path}');
                          setState(() {});
                        } else {
                          image = null;
                          setState(() {});
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 400,
                            width: 392,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.grey.withOpacity(0.3)),
                            child: image == null
                                ? const Icon(Icons.image, size: 60)
                                : Image.file(image!, fit: BoxFit.cover),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.add_a_photo, size: 30),
                              ),
                              SizedBox(width: 100),
                              IconButton(
                                onPressed: () async {
                                  image = null;
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete, size: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text('Name : ${data['Name']}'),
                    Text('Number : ${data['Number']}'),
                    Text('Email : ${data['Email']}'),
                    ElevatedButton(
                      onPressed: () async {
                        await Users.doc(widget.uid).update(
                          {
                            "User": false,
                          },
                        );
                      },
                      child: Text("Log Out"),
                    ),
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
