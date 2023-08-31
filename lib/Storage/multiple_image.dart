// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImage extends StatefulWidget {
  const MultipleImage({super.key});

  @override
  State<MultipleImage> createState() => _MultipleImageState();
}

class _MultipleImageState extends State<MultipleImage> {
  ImagePicker imagePicker = ImagePicker();
  File? image;

  List<File> pictures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                icon: const Icon(Icons.camera_alt_outlined),
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
                                icon: const Icon(Icons.image),
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
