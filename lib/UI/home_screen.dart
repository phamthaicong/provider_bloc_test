import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_bloc_test/UI/profile_friend_screen.dart';
import 'package:provider_bloc_test/UI/seach_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/navigation_extention.dart';
import '../UI/post_screen.dart';
import '../BloC/postImageToCould.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Home();
  }
}

class Home extends State<HomeScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    getLocalUser();
  }



void getLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firestoreInstance
        .collection("user")
        .where('email', isEqualTo: prefs.getString('username'))
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        this.setState(() {
          imageUrl = result['image'];
        });
      });
    });
  }

  Widget headerHome() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                context.navigateTo(SeachScreen());
              },
              icon: Icon(Icons.search),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                context.navigateTo(PostScreen());
              },
              icon: Icon(Icons.post_add_rounded),
            ),
          ),
          imageUrl == null
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.network(
                    '$imageUrl',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
        ],
      ),
    );
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
      padding: EdgeInsets.only(top: 55),
      child: StreamBuilder(
        stream: firestoreInstance
            .collection("post")
            .orderBy('timetamp', descending: true)
            .limit(20)
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
                              context.navigateTo(ProfileFriend(uid: snapshot.data.docs[index]['userId']));
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
                                onPressed: () {}),
                            FlatButton(
                                child: Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag_outlined),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text('Theo dõi'),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {}),
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
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          headerHome(),
          userPost(heightS),
        ],
      )),
    );
  }
}
