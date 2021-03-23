import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Home();
  }

}
class Home extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }

}