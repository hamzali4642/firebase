import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class DataController extends GetxController{

  DataController(){

    print("constructor calling");
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
    print("login calling functions");
    getUser();
  }

  cancel(){
    print("logged out canceling streams");

    stream?.cancel();
  }



  Rx<UserModel?> userModel = Rx(null);


  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? stream;
  getUser() {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = FirebaseFirestore.instance
        .collection("users")
        .doc(uid);

    stream = doc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        userModel.value = UserModel.fromMap(snapshot.data()!);
      }else{
        doc.set({
          "email" : FirebaseAuth.instance.currentUser?.email,
        });
      }
    });
  }
}