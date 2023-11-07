import 'package:firebase/controllers/home_controller.dart';
import 'package:firebase/providers/data_provider.dart';
import 'package:firebase/providers/home_provider.dart';
import 'package:firebase/screens/dashboard.dart';
import 'package:firebase/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'controllers/data_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> DataProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
        ChangeNotifierProvider(
          create: (_)=> HomeProvider(),
          child: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {

      Widget  child = FirebaseAuth.instance.currentUser == null ? Login() : Dashboard();

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> child));
    });
    super.initState();
  }


  final home = Get.put(HomeController(), tag: "lafj");
  final data = Get.put(DataController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              home.increment();
            },
            child: Icon(Icons.add,),
          ),

          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () {
              home.increment2();
            },
            child: Icon(Icons.add,),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () {
                print("object1");
                return Text(
                  home.counter.value.toString(),
                  style: TextStyle(
                    fontSize: 50,
                  ),
                );
              }
            ),

            Obx(
               () {

                 print("object2");
                return Text(
                  home.counter2.toString(),
                  style: TextStyle(
                    fontSize: 50,
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
