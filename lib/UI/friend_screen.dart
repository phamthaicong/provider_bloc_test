import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Friend();
  }
}

class Friend extends State<FriendScreen> {
  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  getDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fireStoreInstance
        .collection('addFollow')
        .where("uid", isEqualTo: prefs.getString('uid'))
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((value) {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
