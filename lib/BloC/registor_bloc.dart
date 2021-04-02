import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistorBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final fireStoreInstance = FirebaseFirestore.instance;
  StreamController imageUser = StreamController<String>();
  StreamController _emailController = StreamController<String>();
  StreamController _passwordController = StreamController<String>();
  StreamController _fullnameController = StreamController<String>();
  StreamController _phoneNumber = StreamController<String>();

  Future<bool> resgitor(String urlimage,String email, String pass, String fullname, String phonenumber) async {
   await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
    fireStoreInstance.collection("user").doc(_firebaseAuth.currentUser.uid).set({
      "uid":_firebaseAuth.currentUser.uid,
      "image":urlimage,
      "email": email,
      "fullname": fullname,
      "password": pass,
      "phonenumber": phonenumber
    });
  }

}
