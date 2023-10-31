import 'package:cloud_firestore/cloud_firestore.dart';
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

  UserModel? userModel;

  getData() {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = FirebaseFirestore.instance
        .collection("users")
        .doc(uid);
    doc.snapshots().listen((snapshot) {
      if (snapshot.exists) {

        setState(() {
          userModel = UserModel.fromMap(snapshot.data()!);
        });
      }else{
        doc.set({
          "email" : FirebaseAuth.instance.currentUser?.email,
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  int selected = 0;

  @override
  Widget build(BuildContext context) {
    var items = [
      Home(userModel: userModel,),
      Profile(userModel: userModel,),
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
        ],
      ),
      body: items[selected],
    );
  }
}
