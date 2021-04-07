import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider_bloc_test/UI/chat_detail_screen.dart';
import '../Common/navigation_extention.dart';

class MessgerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Messger();
  }
}

class Messger extends State<MessgerScreen> {
  final fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Widget nemberChat(double heightS, double widthS) {
    return Container(
      height: heightS,
      child: StreamBuilder(
        stream: fireStore.collection('user').snapshots(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: widthS * 0.9,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${snapshot.data.docs[index]['image']}'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                            ),
                            Container(
                              width: widthS * 0.48,
                              // color: Colors.red,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      '${snapshot.data.docs[index]['fullname']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    // child: Text('R & D'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                        '${snapshot.data.docs[index]['email']}'),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 50,
                                  height: 100,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.navigateTo(ChatDetail(
                        uidNember: snapshot.data.docs[index]['uid'],
                        nameNember: snapshot.data.docs[index]['fullname'],
                      urlImage: snapshot.data.docs[index]['image'],
                    ));
                    // print("object");
                  },
                );
              },
              itemCount: snapshot.data.docs.length,
            );
          } else {
            return Center(
              child: Text("Loading"),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [nemberChat(size.height, size.width)],
        ),
      ),
    );
  }
}
