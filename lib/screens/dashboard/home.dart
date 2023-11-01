import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/field_dialog.dart';
import 'package:firebase/model/post_model.dart';
import 'package:firebase/widget/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.userModel}) : super(key: key);
  final UserModel? userModel;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostModel> posts = [];

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  getData() {
    stream = FirebaseFirestore.instance
        .collection("posts")
        .snapshots()
        .listen((snapshot) {
      var docs = snapshot.docs;

      posts = [];
      for (var doc in docs) {
        var post = PostModel.fromMap(doc.data());
        posts.add(post);
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => PostDialog(
                    user: widget.userModel,
                  ));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return PostWidget(
              post: posts[i],
            );
          },
          itemCount: posts.length,
        ),
      ),
    );
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }
}
