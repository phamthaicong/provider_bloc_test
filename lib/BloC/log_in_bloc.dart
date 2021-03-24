import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../Widget/validation.dart';

class LogInBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final emailController = StreamController<String>.broadcast();
  final passwordController = StreamController<String>.broadcast();
  // ignore: close_sinks
  final uiController = StreamController<String>.broadcast();
  final value = null;
  get emailStream  => emailController.stream;
  get uiStream => uiController.stream;
  String uid;


  Future<bool>doLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final  user = (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;

    if (user != null) {
      await prefs.setString('username', email);
      await prefs.setString('password', password);
      await prefs.setString('uid', user.uid);

      return true;
    }
    return false;
  }


  void dispose() {
    emailController.close();
    passwordController.close();
  }
}
