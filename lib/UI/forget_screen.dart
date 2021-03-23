import 'package:flutter/material.dart';
import '../Common/navigation_extention.dart';
import 'login_screen.dart';

class ForgetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Forget();
  }
}

class Forget extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
    );
  }
}
