import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_bloc_test/BloC/postImageToCould.dart';
import 'package:provider_bloc_test/BloC/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/navigation_extention.dart';
import 'bottom_navigation.dart';

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Post();
  }
}

class Post extends State<PostScreen> {
  final statusWrite = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  final picker = ImagePicker();
  String userId, username;
  File imagePicker;
  String urlImage, imageUser;

  Widget userPost(double widthS, double heightS) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(left: 10, right: 10, top: 70),
      height: heightS * 0.87,
      child: ListView(
        children: [
          Row(
            children: [
              imageUser == null
                  ? SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.network(
                        '$imageUser',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 13),
                      child: Text(
                        '$username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          imagePicker == null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(top: 5),
                  width: widthS * 0.8,
                  height: heightS * 0.4,
                  child: TextField(
                    // style: back,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                        hintText: "Bạn đang nghĩ gì ?"),
                  ),
                )
              : Container(
                  width: widthS * 0.8,
                  height: heightS * 0.5,
                  child: ListView(
                    children: [
                      TextField(
                        controller: statusWrite,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Bạn đang nghĩ gì ?"),
                      ),
                      Stack(
                        children: [
                          Image.file(
                            imagePicker,
                            width: widthS,
                            height: 450,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    this.setState(() {
                                      imagePicker = null;
                                    });
                                  })
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: FlatButton(
                color: Colors.white,
                child: Container(
                  // margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.add_photo_alternate_outlined),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('Thêm ảnh'),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  pickImage();
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: FlatButton(
                color: Colors.white,
                child: Container(
                  // margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('Check in'),
                      )
                    ],
                  ),
                ),
                onPressed: () {}),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: FlatButton(
                color: Colors.white,
                child: Container(
                  // margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.tag_faces),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('Cảm xúc'),
                      )
                    ],
                  ),
                ),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget headerScreen() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  context.replaceWith(BottomNavigation());
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tạo bài viết',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 15),
            child: SizedBox(
              width: 75,
              height: 35,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  PostBloc().PostNews(
                      imageUser,
                      userId,
                      urlImage,
                      statusWrite.text,
                      username,
                      DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: Text(
                  "Đăng",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void pickImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imagePicker = File(image.path);
    });
    String url = await PostImage().PostImageToCloud(imagePicker);
    this.setState(() {
      urlImage = url;
    });
    print('link--->$urlImage');
  }

  void _getLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    firestoreInstance
        .collection("user")
        .where('email', isEqualTo: prefs.getString('username'))
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        this.setState(() {
          imageUser = result['image'];
          username = result['fullname'];
          userId = uid;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [userPost(widthS, heightS), headerScreen()],
          ),
        ),
      ),
    );
  }
}
