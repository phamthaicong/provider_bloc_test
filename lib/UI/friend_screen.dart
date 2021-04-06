import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  String uid;

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  getDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.setState(() {
      uid = prefs.getString('uid');
    });
    print('id-------------->$uid');
  }

  @override
  Widget build(BuildContext context) {
    // double widthS = MediaQuery().of
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: fireStoreInstance
            .collection("addFollow")
            .where('userid', isEqualTo: uid)
            .snapshots(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(top: 5, left: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.network(
                          '${snapshot.data.docs[index]['image']}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        // width: wi,
                        height: 100,
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data.docs[index]['username']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                FlatButton(
                                    onPressed: () {}, child: Text('Thêm bạn')),
                                FlatButton(onPressed: () {}, child: Text('Xóa'))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.docs.length,
            );
          } else {
            return Center(
              child: Text('loading....'),
            );
          }
        },
      )),
    );
  }
}
