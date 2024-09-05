import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import './screens/auth/methods/login_screen.dart';
import './screens/auth/methods/signup_screen.dart';
// import 'package:holbegram/screens/auth/methods/upload_image_screen.dart';
// import './screens/home_screen.dart';
// import './screens/auth/methods/upload_image_screen.dart';


Future main() async {
  // try { WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(const MyApp());
  // } catch(e) {
  //  print('ERROR FOUND = $e');
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPufCwf4CSvyLT3rQSpAvieb50kPls6sc",
      appId: "1:141683300243:android:25dc344678da48fe613a66",
      messagingSenderId: "141683300243",
      projectId: "holbegram-6ab19",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holbegram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        ),
        '/signup': (context) => SignUp(
          emailController: TextEditingController(), 
          usernameController: TextEditingController(), 
          passwordController: TextEditingController(), 
          passwordConfirmController: TextEditingController(),
        ),
        // '/home': (context) => ,
      },
      // home: LoginScreen(emailController: TextEditingController(), passwordController: TextEditingController()),
      //--------------test
      // routes: {
      //   '/': (context) => LoginScreen(emailController: TextEditingController(), passwordController: TextEditingController()),
        // '/': (context) => AddPicture(
        //   email: 'example@email.com',
        //   password: 'password',
        //   username: 'username',
        // ),
        // '/signup': (context) => SignUp(emailController: TextEditingController(), usernameController: TextEditingController(), passwordController: TextEditingController(), passwordConfirmController: TextEditingController()),
        // '/home': (context) => HomeScreen(),
      // }
      //-----------------------------
      // home: AddPicture(
      //   email: 'example@email.com',
      //   password: 'password',
      //   username: 'username',
      // ),
    );
  }
}

