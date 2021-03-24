import 'package:flutter/material.dart';
import 'package:provider_bloc_test/UI/seach_screen.dart';
import '../Common/navigation_extention.dart';
import '../UI/post_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Home();
  }
}

class Home extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget headerHome() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                context.navigateTo(SeachScreen());
              },
              icon: Icon(Icons.search),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                context.navigateTo(PostScreen());
              },
              icon: Icon(Icons.post_add_rounded),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: Image.network(
              'https://www.esoftner.com/wp-content/uploads/2019/11/Balsamiq-Mockups.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
  Widget userPost(){
    return Container(
      child: Column(
        children: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          headerHome(),
        ],
      )),
    );
  }
}
