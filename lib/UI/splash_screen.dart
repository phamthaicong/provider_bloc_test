import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/logo_nms.dart';
import '../Common/navigation_extention.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../Common/common.dart' as Common;
import '../BloC/log_in_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Splash();
  }
}

class Splash extends State<SplashScreen> {
  final logInBloc = LogInBloc();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: Common.TIME_SCREEN),
        () => context.replaceWith(LoginScreen()));
    // autoLogin();
  }

  void autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    String password = prefs.getString('password');
    logInBloc.doLogin(username, password).then((value) => {
          if (value == true)
            {context.replaceWith(HomeScreen())}
          else
            {context.replaceWith(LoginScreen())}
        });
  }

  @override
  Widget build(BuildContext context) {
    double heightS = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          WidgetLogo(),
          Container(
            padding: EdgeInsets.only(bottom: heightS * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
