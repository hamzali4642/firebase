import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/post_model.dart';
import 'package:firebase/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FieldDialog extends StatefulWidget {
  const FieldDialog({Key? key, this.value, required this.keyValue})
      : super(key: key);
  final String? value;
  final String keyValue;

  @override
  State<FieldDialog> createState() => _FieldDialogState();
}

class _FieldDialogState extends State<FieldDialog> {
  var text = TextEditingController();

  @override
  void initState() {
    text.text = widget.value ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: text,
      ),
      actions: [
        TextButton(
          onPressed: () {
            var uid = FirebaseAuth.instance.currentUser!.uid;
            FirebaseFirestore.instance.collection("users").doc(uid).update({
              widget.keyValue: text.text,
            });
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}

class PostDialog extends StatefulWidget {
  const PostDialog({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  State<PostDialog> createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  var text = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: text,
      ),
      actions: [
        TextButton(
          onPressed: () {
            var uid = FirebaseAuth.instance.currentUser!.uid;
            var doc = FirebaseFirestore.instance.collection("posts").doc();
            var post = PostModel(
              name: widget.user?.name,
              image: widget.user?.image,
              uid: uid,
              id: doc.id,
              text: text.text,
            );
            doc.set(post.toMap());
            Navigator.of(context).pop();
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
