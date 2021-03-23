import 'package:flutter/material.dart';
import '../Common/navigation_extention.dart';

class FlatButtonCustom extends StatelessWidget {
  final Widget destinationTo;
  final String name_button;

  FlatButtonCustom({@required this.destinationTo, @required this.name_button});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FlatButton(
        child: Text(
          name_button,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
              fontFamily: 'Roboto'),
        ),
        onPressed: () {
          context.navigateTo(destinationTo);
        },
      ),
    );
  }
}
