import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ChatDetail extends StatefulWidget {
  String uidNember;
  String nameNember;
  String urlImage;

  ChatDetail({@required this.uidNember,
    @required this.nameNember,
    @required this.urlImage});

  @override
  State<StatefulWidget> createState() {
    return Chat(
        uidNember: uidNember, nameNember: nameNember, urlImage: urlImage);
  }
}

class Chat extends State<ChatDetail> {
  final fireStore = Firestore.instance;
  final mess = TextEditingController();
  String urlImage;
  String uidNember;
  String nameNember;

  Chat({@required this.uidNember,
    @required this.nameNember,
    @required this.urlImage});

  sendMess() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    fireStore.collection('chats').add({
      "uid1": pres.getString("uid"),
      "uid2": uidNember,
      "timetemp": DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      "messger": mess.text.toString()
    });
    mess.clear();
  }

  Widget getMessNember() {
    return Container(
      child: StreamBuilder(
        stream: fireStore.collection('chats').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child:Text(""),
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
    Size size = MediaQuery
        .of(context)
        .size;
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 5),
                        height: 50,
                        width: size.width * 0.85,
                        child: TextField(
                          controller: mess,
                          decoration: InputDecoration(
                              hintText: "Chat gi ?",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
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
