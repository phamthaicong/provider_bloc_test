import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../Common/navigation_extention.dart';
import 'home_screen.dart';

// ignore: must_be_immutable
class ImageFullScreen extends StatefulWidget {
  String url;

  ImageFullScreen({@required this.url});

  @override
  State<StatefulWidget> createState() => ImageScreen(url: url);
}

class ImageScreen extends State<ImageFullScreen> {
  String url;

  ImageScreen({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(url),
          ),
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    ));
  }
}
