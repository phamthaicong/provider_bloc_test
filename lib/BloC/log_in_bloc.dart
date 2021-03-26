import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../Widget/validation.dart';

class LogInBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String uid;
  final emailController = StreamController<String>.broadcast();
  final passwordController = StreamController<String>.broadcast();
  final imageController = StreamController<String>.broadcast();
  final uiController = StreamController<String>.broadcast();
  final usernameController = StreamController<String>.broadcast();
  final value = null;

  get emailStream => emailController.stream;

  get uiStream => uiController.stream;

  get passStream => passwordController.stream;

  get imageStream => imageController.stream;

  Future<bool> doLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      await prefs.setString('username', email);
      await prefs.setString('password', password);
      await prefs.setString('uid', user.uid);
      getInforUser(email);
      print("login---> $getInforUser");
      return true;
    }
    return false;
  }

  // ignore: missing_return
  getInforUser(String email) async {
    firestoreInstance
        .collection("user")
        .where('email', isEqualTo: email)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        uiController.sink.add(result['uid']);
        emailController.sink.add(result['email']);
        imageController.sink.add(result['image']);
      });
    });
  }

  void dispose() {
    emailController.close();
    passwordController.close();
  }
}
