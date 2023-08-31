import 'package:flutter/material.dart';

import 'home_scrren.dart';

class BottomNavRegister extends StatefulWidget {
  const BottomNavRegister({super.key, this.userid});
  final userid;
  @override
  State<BottomNavRegister> createState() => _BottomNavRegisterState();
}

class _BottomNavRegisterState extends State<BottomNavRegister> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenRegister(uid: widget.userid),
                  ),
                );
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
