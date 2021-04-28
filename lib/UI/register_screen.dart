import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:provider_bloc_test/BloC/postImageToCould.dart';
import 'package:provider_bloc_test/BloC/registor_bloc.dart';
import 'package:provider_bloc_test/UI/login_screen.dart';
import 'package:provider_bloc_test/Widget/validation.dart';
import '../Common/navigation_extention.dart';
import '../Common/colors.dart' as Common;
import '../Common/common.dart' as Common;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'bottom_navigation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Register();
  }
}

class Register extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  File imagePicker;
  final picker = ImagePicker();
  bool showPass = true;
  bool onClick = true;
  String ImageURL;
  final _formKey = GlobalKey<FormState>();

  _resgistor() {
    this.setState(() {
      onClick = !onClick;
    });
    RegistorBloc()
        .resgitor(ImageURL, emailController.text, passwordController.text,
            fullNameController.text, phoneNumberController.text)
        .then((value) => Timer(
            Duration(seconds: 2), () => context.replaceWith(LoginScreen())));
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
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  padding: EdgeInsets.only(top: widthS * 0.1),
                  children: [
                    FlatButton(
                      onPressed: () {
                        getImageFromGallery();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: imagePicker == null
                            ? Image.network(
                          'https://www.esoftner.com/wp-content/uploads/2019/11/Balsamiq-Mockups.png',
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Email ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        height: 70,
                        child: TextFormField(
                          validator:(value){
                            return Validation().checkUsername(value);
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            // icon: Icon(Icons.supervised_user_circle_outlined)
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Password ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        height: 70,
                        child: TextFormField(
                          validator: (value){
                            return Validation().checkPassword(value);
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                          controller: passwordController,
                          obscureText: showPass,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: showPass == true
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.panorama_fish_eye),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        height: 70,
                        child: TextFormField(
                          validator: (value){
                            return Validation().checkEmty(value);
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                          controller: fullNameController,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        height: 70,
                        child: TextFormField(
                          validator: (value){
                            return Validation().checkPhoneNumber(value);
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold),
                            )
                                : CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation(Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _resgistor();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        context.replaceWith(LoginScreen());
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
