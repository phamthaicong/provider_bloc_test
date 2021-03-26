import 'package:flutter/material.dart';
import 'package:provider_bloc_test/UI/bottom_navigation.dart';
import 'package:provider_bloc_test/UI/forget_screen.dart';
import 'package:provider_bloc_test/UI/home_screen.dart';
import 'package:provider_bloc_test/UI/register_screen.dart';
import 'package:provider_bloc_test/Widget/flat_button_action.dart';
import '../Widget/logo_nms.dart';
import '../Common/common.dart' as Common;
import '../Common/colors.dart' as Common;
import '../Common/navigation_extention.dart';
import '../BloC/log_in_bloc.dart';
import '../Widget/validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Login();
  }
}

class Login extends State<LoginScreen> {
  final usernameControl = TextEditingController();
  final passwordControl = TextEditingController();
  bool showPass = true;
  bool onClick = false;
  final logBloc = LogInBloc();

  void loginUser() async {
    this.setState(() {
      // ignore: unnecessary_statements
      onClick != onClick;
    });
    LogInBloc()
        .doLogin(usernameControl.text, passwordControl.text)
        .then((value) => {
              print("value--->${value}"),
              if (value == true) {context.replaceWith(BottomNavigation())}
            });
  }

  Widget InputUser() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Username ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            height: 80,
            child: TextField(
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
              controller: usernameControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // icon: Icon(Icons.supervised_user_circle_outlined)
              ),
            )),
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Row(
            children: [
              Text(
                "${Validation().checkUsername(usernameControl.text)}",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }




  Widget InputPassword() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Password ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 10),
            height: 80,
            child: TextField(
              maxLength: 12,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
              controller: passwordControl,
              obscureText: showPass,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  // icon: Icon(Icons.sports_hockey_sharp)
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
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Row(
            children: [
              Text(
                "${Validation().checkPassword(passwordControl.text)}",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget ButtonLogin() {
    return IntrinsicHeight(
      child: Container(
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            color: Common.btnLog,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Common.RADIUS)),
            ),
            child: onClick == false
                ? Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  )
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              loginUser();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: widthS * 0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetLogo(),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: InputUser(),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: InputPassword(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButtonCustom(
                    destinationTo: RegisterScreen(), name_button: "Đăng ký"),
                FlatButtonCustom(
                    destinationTo: ForgetScreen(),
                    name_button: "Bạn quên mật khẩu ?")
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: ButtonLogin(),
            )
          ],
        ),
      ),
    ));
  }
}
