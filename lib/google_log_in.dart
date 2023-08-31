import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login With Google")),
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _googleSignIn.signOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                          });
                        }).catchError((e) {});
                      },
                      child: const Center(child: Text("Logout")))
                ],
              )
            : Center(
                child: ElevatedButton(
                  child: const Text("Login with Google"),
                  onPressed: () {
                    _googleSignIn.signIn().then(
                      (userData) {
                        setState(
                          () {
                            _isLoggedIn = true;
                            _userObj = userData!;
                          },
                        );
                      },
                    ).catchError(
                      (e) {
                        print(e);
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
