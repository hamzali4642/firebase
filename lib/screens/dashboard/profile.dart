import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controllers/data_controller.dart';
import 'package:firebase/field_dialog.dart';
import 'package:firebase/model/user_model.dart';
import 'package:firebase/providers/data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, }) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  DataController dataProvider = Get.find();
  @override
  Widget build(BuildContext context) {

    return Obx(
      () {
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
                      dataProvider.userModel.value?.image ??
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
                  dataProvider.userModel.value?.name ?? "Name",
                      () {
                    showDialog(context: context, builder: (_)=> FieldDialog(keyValue: "name", value: dataProvider.userModel.value?.name,));
                  },
                ),
                itemWidget(
                  dataProvider.userModel.value?.email ?? FirebaseAuth.instance.currentUser!.email!,
                  null,
                ),
              ],
            ),
          ),
        );
      }
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
