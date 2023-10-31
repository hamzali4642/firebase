import 'package:firebase/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  hintText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Dashboard()));
                });
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
