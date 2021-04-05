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
  String imageUser;

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
        this.setState(() {
          name = value['fullname'];
          imageUser=value['image'];
        });
      });
    });
    print('hello---->$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       children: [
         ClipRRect(

         )
       ],
      ),
    );
  }
}
