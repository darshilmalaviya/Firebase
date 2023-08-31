import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordConfirmation extends StatefulWidget {
  @override
  _PasswordConfirmationState createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  late String password;
  late String confirmPassword;

  bool _isPasswordMatched = true;

  void _validatePassword() {
    setState(() {
      _isPasswordMatched = password == confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Confirmation'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              password = value;
              _validatePassword();
            },
            decoration: InputDecoration(
              hintText: 'Enter Password',
            ),
            obscureText: true,
          ),
          TextField(
            onChanged: (value) {
              confirmPassword = value;
              _validatePassword();
            },
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            _isPasswordMatched ? '' : 'Passwords do not match',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
