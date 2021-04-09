import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ChatDetail extends StatefulWidget {
  String uidNember;
  String nameNember;
  String urlImage;

  ChatDetail(
      {@required this.uidNember,
      @required this.nameNember,
      @required this.urlImage});

  @override
  State<StatefulWidget> createState() {
    return Chat(uidNember: uidNember, nameNember: nameNember, urlImage: urlImage);
  }
}

class Chat extends State<ChatDetail> {
  final fireStore = FirebaseFirestore.instance;
  final mess = TextEditingController();
  String urlImage;
  String uidNember;
  String nameNember;
  String uid;

  Chat(
      {@required this.uidNember,
      @required this.nameNember,
      @required this.urlImage});

  sendMess() async {
    fireStore.collection('chats').add({
      "uid1": uid,
      "uid2": uidNember,
      "timetemp": DateTime.now().millisecondsSinceEpoch.toString(),
      "messger": mess.text.toString()
    });
    mess.clear();
  }

  Widget getMessNember() {
    return Container(
      child: StreamBuilder(
        stream: fireStore
            .collection('chats')
            .orderBy('timetemp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return uid == snapshot.data.docs[index]['uid1']
                    ? Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 7, top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 5),
                                  child: Text(
                                    '${snapshot.data.docs[index]['messger']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 5),
                                  child: Text(
                                    '  ${snapshot.data.docs[index]['messger']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
              },
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
  void initState() {
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    this.setState(() {
      uid = pres.getString("uid");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("$nameNember"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10, top: 3, bottom: 3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "$urlImage",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 60, left: 25, right: 25),
            child: getMessNember(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    height: 50,
                    width: size.width * 0.85,
                    child: TextField(
                      controller: mess,
                      decoration: InputDecoration(
                          hintText: "Chat gi ?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 20,
                      ),
                      onPressed: () {
                        sendMess();
                      })
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
