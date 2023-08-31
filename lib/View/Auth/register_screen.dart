import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Register'),
          onPressed: () async {
            UserCredential userCredential =
                await auth.signInWithEmailAndPassword(
                    email: 'darshil@gmail.com', password: '123456');

            print('DATA ${userCredential.user!.uid}');
          },
        ),
      ),
    );
  }
}
