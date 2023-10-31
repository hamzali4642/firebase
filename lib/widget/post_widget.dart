import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/post_model.dart';
import 'package:firebase/model/user_model.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image(
                          image: NetworkImage(
                            post.image ??
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          ),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          post.name ?? "Name",
                        ),
                      ),
                    ],
                  ),
                  Text(post.text),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            FirebaseFirestore.instance.collection("posts").doc(post.id)
                .update({
              "text" : "kasg jkahsgd jhgdas kjgasd jgdasjhggdfs sdfasd, lajksh kjahsd kjdah",
              "name" : "Hamza",
            });
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
