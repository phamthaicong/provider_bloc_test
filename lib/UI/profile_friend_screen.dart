import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileFriend extends StatefulWidget {
  String uid;

  ProfileFriend({@required this.uid});

  @override
  State<StatefulWidget> createState() {
    return Profile(uid: uid);
  }
}

class Profile extends State<ProfileFriend> {
  String uid;
  final fireStore = Firestore.instance;
  String name;

  Profile({@required this.uid});

  @override
  void initState() {
    super.initState();
    getInfoUser();
  }

  getInfoUser() async {
    fireStore
        .collection('user')
        .where('uid', isEqualTo: uid)
        .get()
        .then((dataQuery) {
      dataQuery.docs.forEach((value) {
        print('${value['fullname']}');
        this.setState(() {
          name = value['fullname'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$uid'),
      ),
    );
  }
}
