import 'package:flutter/material.dart';
import 'package:provider_bloc_test/UI/home_screen.dart';
import '../Common/navigation_extention.dart';


class PostScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Post();
  }

}
class Post extends State<PostScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.replaceWith(HomeScreen());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}