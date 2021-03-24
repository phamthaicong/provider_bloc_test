import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider_bloc_test/BloC/log_in_bloc.dart';
import 'package:provider_bloc_test/BloC/postImageToCould.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/colors.dart' as Common;
import '../Common/common.dart' as Common;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Profile();
  }
}

class Profile extends State<ProfileScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  File imagePicker;
  final picker = ImagePicker();
  bool showPass = true;
  bool onClick = true;
  String emailLocal;
  final loginBloc = LogInBloc();
  String uid;
  String ImageURL;

  @override
  void initState() {
    getLocalUser();
    super.initState();
  }

  void getImageFromGallery() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imagePicker = File(picture.path);
    });
    String urlImage = await PostImage().PostImageToCloud(imagePicker);
    this.setState(() {
      ImageURL = urlImage;
    });
    print('profile image$ImageURL');
  }

  void getLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    String userid = prefs.getString('uid');
    this.setState(() {
      emailLocal = username;
      uid = userid;
    });
    firestoreInstance
        .collection("user")
        .where('email', isEqualTo: emailLocal)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        emailController.text = result.data()['email'];
        passwordController.text = result.data()['password'];
        fullNameController.text = result.data()['fullname'];
        phoneNumberController.text = result.data()['phonenumber'];
        print(result.data());
      });
    });
  }

  void updateUser() async {
    this.setState(() {
      onClick = true;
    });
    firestoreInstance.collection('user').doc(uid).updateData({
      "image": ImageURL,
      "password": passwordController.text,
      "phonenumber": phoneNumberController.text,
      "fullname": fullNameController.text,
      "email": emailController.text,
    });
    Timer(Duration(seconds: 3), () {
      this.setState(() {
        onClick = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: firestoreInstance.collection("user").snapshots(),
          // ignore: missing_return
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) =>
                      emailLocal == snapshot.data.docs[index]["email"]
                          ? Container(
                              padding: EdgeInsets.only(top: widthS * 0.2),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      child: imagePicker == null
                                          ? Image.network(
                                              '${snapshot.data.docs[index]["image"] == null ? 'https://www.esoftner.com/wp-content/uploads/2019/11/Balsamiq-Mockups.png' : snapshot.data.docs[index]["image"]}',
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              imagePicker,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      height: 70,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700]),
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          // icon: Icon(Icons.supervised_user_circle_outlined)
                                        ),
                                      )),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 5),
                                      height: 70,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700]),
                                        controller: passwordController,
                                        obscureText: showPass,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                            suffixIcon: IconButton(
                                              icon: showPass == true
                                                  ? Icon(Icons.remove_red_eye)
                                                  : Icon(
                                                      Icons.panorama_fish_eye),
                                              onPressed: () {
                                                this.setState(() {
                                                  showPass = !showPass;
                                                });
                                              },
                                            )),
                                      )),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Full Name ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      height: 70,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700]),
                                        controller: fullNameController,
                                        // keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      )),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone Number ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      height: 70,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700]),
                                        controller: phoneNumberController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      )),
                                  IntrinsicHeight(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          color: Common.btnLog,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Common.RADIUS)),
                                          ),
                                          child: onClick == true
                                              ? Text(
                                                  'Cập nhật',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.white),
                                                ),
                                          onPressed: () {
                                            updateUser();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Common.RADIUS)),
                                          ),
                                          child: Text(
                                            'Đăng xuất',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(""),
                            ));
            } else {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue)),
              );
            }
          },
        ),
      ),
    );
  }
}
