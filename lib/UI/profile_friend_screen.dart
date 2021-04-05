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
        print('${value['fullname']}');
        this.setState(() {
          name = value['fullname'];
          imageUser = value['image'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:  Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.network(imageUser,width: 150,height: 150,fit: BoxFit.cover,),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
