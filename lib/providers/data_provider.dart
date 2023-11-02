import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class DataProvider with ChangeNotifier{
  DataProvider(){
    FirebaseAuth.instance.userChanges().listen((user) {
      if(user == null){
        //logout
        cancel();
      }else{
        //logged in
        callFunctions();
      }
    });
  }


  callFunctions(){
    getUser();
  }

  cancel(){
    stream?.cancel();
  }



  UserModel? userModel;


  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? stream;
  getUser() {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = FirebaseFirestore.instance
        .collection("users")
        .doc(uid);

    stream = doc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        notifyListeners();
      }else{
        doc.set({
          "email" : FirebaseAuth.instance.currentUser?.email,
        });
      }
    });
  }
}