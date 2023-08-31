import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageUpload extends StatefulWidget {
  const MultipleImageUpload({super.key});

  @override
  State<MultipleImageUpload> createState() => _MultipleImageUploadState();
}

class _MultipleImageUploadState extends State<MultipleImageUpload> {
  ImagePicker imagePicker = ImagePicker();
  File? image;

  List<File> pictures = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      XFile? file = await imagePicker.pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 100);

                                      image = File(file!.path);
                                      pictures.add(image!);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera_alt_outlined,
                                        size: 50),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      XFile? file = await imagePicker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 100);

                                      image = File(file!.path);
                                      pictures.add(image!);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image, size: 50),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Select images"),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        for (int i = 0; i <= pictures.length; i++) {
                          await storage
                              .ref("profile/user$i.png")
                              .putFile(pictures[i])
                              .then((p0) async {
                            String url = await p0.ref.getDownloadURL();

                            print('URL $url');
                          });
                        }
                      },
                      child: Text('Upload')),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: pictures.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 700,
                    width: 392,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.withOpacity(0.3)),
                    child: pictures.isEmpty
                        ? const Icon(Icons.image, size: 60)
                        : Image.file(pictures[index], fit: BoxFit.cover),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
