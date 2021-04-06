import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Common/navigation_extention.dart';

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
  String imageUser, writePost, imageUrl;

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
          imageUser = value['image'];
        });
      });
    });
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  Widget userPost(double heightS) {
    return Container(
      height: heightS*0.7,
      padding: EdgeInsets.only(top: 5),
      child: StreamBuilder(
        stream: fireStore
            .collection("post")
            .where('userId', isEqualTo: uid)
            // .orderBy('timetamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.network(
                              '${snapshot.data.docs[index]['imageUser']}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                context.navigateTo(ProfileFriend(
                                    uid: snapshot.data.docs[index]['userId']));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 13),
                                child: Column(
                                  children: [
                                    Text(
                                      '${snapshot.data.docs[index]['userCreator']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${readTimestamp(int.parse(snapshot.data.docs[index]['timetamp']))}',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          child: Icon(
                                            Icons.timelapse,
                                            size: 10,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, right: 5),
                        child: Row(
                          children: [
                            Text(
                              '${snapshot.data.docs[index]['writePost']}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ClipRRect(
                          child: Image.network(
                            '${snapshot.data.docs[index]['imageUrl']}',
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1),
                                top: BorderSide(color: Colors.grey, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                                child: Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.accessibility),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text('Thích'),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  print('thích');
                                }),
                            FlatButton(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag_outlined),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text('Theo  dõi'),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  // addFollow(
                                  //     snapshot.data.docs[index]['userId'],
                                  //     snapshot.data.docs[index]['imageUser'],
                                  //     snapshot.data.docs[index]['userCreator']);
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightS = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageUser == null
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.network(
                            imageUser,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
            userPost(heightS)
          ],
        ),
      ),
    );
  }
}
