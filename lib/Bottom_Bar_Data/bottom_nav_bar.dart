import 'package:firebase/Bottom_Bar_Data/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../Log in Firestore/home_screen.dart';
import 'home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int select = 0;
  List screens = [
    const HomeScreenMultipleData(),
    const ProfileShowData(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            hoverColor: Colors.grey, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 20,
            curve: Curves.easeInExpo, // tab animation curves
            duration:
                const Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 20, // tab button icon size
            tabBackgroundColor: Colors.orange, // selected tab background color
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 10), // navigation bar padding
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
              )
            ],
          ),
        ),
        body: screens[select],
      ),
    );
  }
}
