
import 'package:flutter/material.dart';



class ImageFullScreen extends StatefulWidget{
  String url;
  ImageFullScreen({@required this.url});

  @override
  State<StatefulWidget> createState() {
    return ImageScreen(url: url);
  }

}


class ImageScreen extends State<ImageFullScreen>{
  String url;
  ImageScreen({@required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        "$url",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

}