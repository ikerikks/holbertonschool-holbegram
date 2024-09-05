import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({required BuildContext context, required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill all the fields";
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message ?? 'An error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return "Please fill all the fields";
    } else if (password != confirmPassword) {
      return "Same password required";
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      Users newUser = Users(
        uid: user?.uid ?? '',
        email: email,
        username: username,
        bio: '',
        photoUrl: '',
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: username.toLowerCase(),
      );
      
      await _firestore.collection("users").doc(user?.uid).set(newUser.toJson());
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<Users> getUserDetails() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userSnapshot = await _firestore.collection("users").doc(currentUser.uid).get();
        if (userSnapshot.exists) {
          return Users.fromSnap(userSnapshot.data() as DocumentSnapshot<Map<String, dynamic>>);
        } else {
          throw "User not found";
        }
      } else {
        throw "No user signed in";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
