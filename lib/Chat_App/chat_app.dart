import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key, this.uid}) : super(key: key);
  final uid;
  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  final User? user = FirebaseAuth.instance.currentUser;

  CollectionReference Users = FirebaseFirestore.instance.collection('Chat');
  TextEditingController chat = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.network(
                'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
            SizedBox(

              child: StreamBuilder(
                stream: Users.orderBy('time').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: widget.uid == data['userid']
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: widget.uid == data['userid']
                                      ? Colors.grey
                                      : Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Center(
                                    child: Text(
                                      '${data['chat']}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
            Container(
              height: 50,
              width: 392,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: chat,
                onSubmitted: (value) {
                  if (chat.text == '') {
                    return;
                  } else {
                    Users.add(
                      {
                        "chat": chat.text,
                        "userid": user!.uid,
                        "time": DateTime.now(),
                      },
                    );
                  }
                  chat.clear();
                },
                decoration: InputDecoration(
                  hintText: "Send a massage",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (chat.text == '') {
                        return;
                      } else {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: 500));

                        Users.add(
                          {
                            "chat": chat.text,
                            "userid": user!.uid,
                            "time": DateTime.now(),
                          },
                        );
                      }
                      chat.clear();
                    },
                    child: const Icon(
                      Icons.send,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
