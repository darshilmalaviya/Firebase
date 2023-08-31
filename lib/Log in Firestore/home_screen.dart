// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.uid}) : super(key: key);

  final uid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference Users = FirebaseFirestore.instance.collection('users');
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Users.doc("${widget.uid}").update({
              "First name": firstName.text,
              "Last name": lastName.text,
              "Gender": gender.text,
              "Email": email.text,
            });
          },
        ),
        body: FutureBuilder(
          future: Users.doc('${widget.uid}').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              firstName.text = data['First name'];
              lastName.text = data['Last name'];
              gender.text = data['Gender'];
              email.text = data['Email'];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text('First Name : ${data['First name']}')),
                    Center(child: Text('Last Name : ${data['Last name']}')),
                    Center(child: Text('Gender : ${data['Gender']}')),
                    Center(child: Text('Email : ${data['Email']}')),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: firstName,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                    TextField(
                      controller: lastName,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    TextField(
                      controller: gender,
                      decoration: const InputDecoration(
                        hintText: 'Gender',
                      ),
                    ),
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
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
