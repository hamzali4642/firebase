
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/dashboard/events.dart';
import 'package:firebase/screens/dashboard/home.dart';
import 'package:firebase/screens/dashboard/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {



  @override
  void initState() {
    super.initState();
  }


  int selected = 0;

  @override
  Widget build(BuildContext context) {
    var items = [
      Home(),
      Profile(),
      Events(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,

        onTap: (i) {

          setState(() {
            selected = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Event"),
        ],
      ),
      body: items[selected],
    );
  }
}
