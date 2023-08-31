import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteData extends StatefulWidget {
  const DeleteData({Key? key}) : super(key: key);

  @override
  State<DeleteData> createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  CollectionReference Users = FirebaseFirestore.instance.collection('users');

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
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
                              controller: email,
                              decoration: const InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                            TextField(
                              controller: name,
                              decoration: const InputDecoration(
                                hintText: "Name",
                              ),
                            ),
                            TextField(
                              controller: number,
                              decoration: const InputDecoration(
                                hintText: "Numbers",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: MaterialButton(
                                height: 50,
                                color: Colors.blue,
                                onPressed: () async {
                                  email.clear();
                                  name.clear();
                                  number.clear();
                                  await Users.add(
                                    {
                                      "email": email.text,
                                      "name": name.text,
                                      "number": number.text,
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
                });
          },
        ),
        body: FutureBuilder(
          future: Users.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  print('${snapshot.data!.docs[index].id}');

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () {
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
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            height: 50,
                                            color: Colors.blue,
                                            onPressed: () async {
                                              await Users.doc(
                                                      "${snapshot.data!.docs[index].id}")
                                                  .delete();
                                            },
                                            child:
                                                const Text("Delete All Data"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.1,
                        color: Colors.grey,
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text('Email : ${data['email']}'),
                              ),
                              Text('Name : ${data['name']}'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text('Number : ${data['number']}'),
                              ),
                            ],
                          ),
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
