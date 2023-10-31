import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? image;
  String? email;

  UserModel({
    required this.name,
    required this.image,
    required this.email,
  });

  UserModel.fromMap(Map<String, dynamic> data){
    name = data["name"];
    image = data["image"];
    email = data["email"];
  }

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "image": image,
      "email" : email,
    };
  }
}
