import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


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
      body: PhotoView(
        imageProvider: NetworkImage(url),
      )
    );
  }

}