import 'package:flutter/material.dart';

class ProfileFriend extends StatelessWidget {
  String uid;

  ProfileFriend({@required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$uid"),
      ),
    );
  }
}
