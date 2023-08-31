import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileShowData extends StatefulWidget {
  const ProfileShowData({Key? key}) : super(key: key);

  @override
  State<ProfileShowData> createState() => _ProfileShowDataState();
}

class _ProfileShowDataState extends State<ProfileShowData> {
  CollectionReference Users = FirebaseFirestore.instance.collection('users');

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Users.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 150,
                      width: 250,
                      color: Colors.grey,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child:
                                  Text('description : ${data['description']}'),
                            ),
                            Text('name : ${data['name']}'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('price : ${data['price']}'),
                            ),
                            Text('rate : ${data['rate']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
