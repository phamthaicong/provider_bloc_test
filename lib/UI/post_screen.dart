import 'package:flutter/material.dart';
import '../Common/navigation_extention.dart';
import 'bottom_navigation.dart';


class PostScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Post();
  }

}
class Post extends State<PostScreen>{
  Widget userPost(){
    return ListView(
      children: [
        
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          context.replaceWith(BottomNavigation());
                        },
                      ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Tạo bài viết',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        ),],
                    ),
                   Container(
                     padding: EdgeInsets.only(right: 15),
                     child:  SizedBox(
                       width: 75,
                       height: 35,
                       child: RaisedButton(
                         onPressed: (){},
                         child: Text("Đăng"),
                       ),
                     ),
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