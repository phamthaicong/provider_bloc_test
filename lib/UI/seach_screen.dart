import 'package:flutter/material.dart';
import 'package:provider_bloc_test/Common/colors.dart' as Common;
import '../Common/navigation_extention.dart';
import 'bottom_navigation.dart';

class SeachScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Seach();
  }
}

class Seach extends State<SeachScreen> {
  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1))),
              child: Row(
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
                    width: widthS * 0.8,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor:Common.textInputSeach,
                        filled: true,
                        contentPadding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 20),
                        hintText: " Tìm kiếm ",
                        border: InputBorder.none,
                      ),
                    ),
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
