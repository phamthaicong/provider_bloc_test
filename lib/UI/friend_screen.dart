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
    // print('id-------------->$uid');
  }
  Widget getListAddFollow(){
    return StreamBuilder(
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
                // color: Colors.red,
                height: 100,
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.network(
                        '${snapshot.data.docs[index]['image']}',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // width: wi,
                      // height: 100,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              Container(
                                padding: EdgeInsets.only(left: 7),
                                child: SizedBox(
                                  child: FlatButton(
                                      color: Colors.redAccent,
                                      onPressed: () {},
                                      child: Text('Thêm bạn')),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: 75,
                                child: FlatButton(
                                    color: Colors.lightBlue,
                                    onPressed: () {},
                                    child: Text('Xóa')),
                              )
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
    );
  }
  Widget headerHome() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Center(
        child: Text("Lời  mời kết bạn ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // double widthS = MediaQuery().of
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              headerHome(),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: getListAddFollow(),
              )
            ],
          )),
    );
  }
}
