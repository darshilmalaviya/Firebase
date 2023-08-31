import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  ImagePicker imagePicker = ImagePicker();

  File? image;

  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () async {
                if (image == null) {
                  XFile? file = await imagePicker.pickImage(
                      source: ImageSource.gallery, imageQuality: 10);

                  image = File(file!.path);
                  print('PATHH ${file.path}');
                  setState(() {});
                } else {
                  image = null;
                  setState(() {});
                }
              },
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.3)),
                child: image == null
                    ? const Icon(Icons.image, size: 60)
                    : Image.file(image!, fit: BoxFit.cover),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    if (image == null) {
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.camera, imageQuality: 10);

                      image = File(file!.path);
                      print('PATHH ${file.path}');
                      setState(() {});
                    } else {
                      image = null;
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.linked_camera)),
              IconButton(
                onPressed: () async {
                  image = null;
                  setState(() {});
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                await storage
                    .ref("profile/user.png")
                    .putFile(image!)
                    .then((p0) async {
                  String url = await p0.ref.getDownloadURL();

                  print('URL ${url}');
                });
              },
              child: Text('Upload')),
        ],
      ),
    );
  }
}
