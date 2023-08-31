import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenMultipleData extends StatefulWidget {
  const HomeScreenMultipleData({Key? key}) : super(key: key);

  @override
  State<HomeScreenMultipleData> createState() => _HomeScreenMultipleDataState();
}

class _HomeScreenMultipleDataState extends State<HomeScreenMultipleData> {
  CollectionReference Users = FirebaseFirestore.instance.collection('users');

  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController rate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: description,
                            decoration: const InputDecoration(
                              hintText: "description",
                            ),
                          ),
                          TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              hintText: "name",
                            ),
                          ),
                          TextField(
                            controller: price,
                            decoration: const InputDecoration(
                              hintText: "price",
                            ),
                          ),
                          TextField(
                            controller: rate,
                            decoration: const InputDecoration(
                              hintText: "rate",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: MaterialButton(
                              height: 50,
                              color: Colors.blue,
                              onPressed: () async {
                                await Users.doc("4kzThfPydVgAySR3TMcHL7q6Rgp2")
                                    .collection('Products')
                                    .add(
                                  {
                                    "description": description.text,
                                    "name": name.text,
                                    "price": price.text,
                                    "rate": rate.text,
                                  },
                                );
                              },
                              child: const Text("Add"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
