import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/field_dialog.dart';
import 'package:firebase/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.userModel}) : super(key: key);

  final UserModel? userModel;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(
          20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image(
                image: NetworkImage(
                  widget.userModel?.image ??
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                ),
                height: 150,
                width: 150,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (_)=> FieldDialog(keyValue: "image"));
              },
              child: const Text("Update Image"),
            ),
            itemWidget(
              widget.userModel?.name ?? "Name",
              () {
                showDialog(context: context, builder: (_)=> FieldDialog(keyValue: "name", value: widget.userModel?.name,));
              },
            ),
            itemWidget(
              widget.userModel?.email ?? FirebaseAuth.instance.currentUser!.email!,
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemWidget(String title, Function()? onTap) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
          ),
        ),
        IconButton(
          onPressed: onTap,
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }
}
