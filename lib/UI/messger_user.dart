import 'package:flutter/material.dart';



class MessgerScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Messger();
  }

}

class Messger extends State<MessgerScreen>{
  @override
  void initState() {
    super.initState();
  }
  Widget buildChat(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }

}