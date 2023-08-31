import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreDemo extends StatefulWidget {
  const FireStoreDemo({Key? key}) : super(key: key);

  @override
  State<FireStoreDemo> createState() => _FireStoreDemoState();
}

class _FireStoreDemoState extends State<FireStoreDemo> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // await users.doc("aZEWylTCiYL7BqEwiFKl").update(
            //   {
            //     "email": "kjhg",
            //     "name": "poiuy",
            //     "number": "hhghhgg",
            //   },
            // );
            //
            // await users.doc("dio6bvWBR49dcUGpkTNB").delete();
            // await users.doc("wfEV2kEy00ZhiycCjdOK").set({"name": "Darshil"});

            // await users.doc('123456789').set({
            //   "name": "new data",
            //   "email": "fghjkk",
            // }
            // );
          },
        ),
        body: FutureBuilder(
          future: users.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[0].data() as Map<String, dynamic>;

              return Center(child: Text('${data['name']}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
