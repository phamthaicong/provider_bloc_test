import 'package:flutter/material.dart';
import '../Common/navigation_extention.dart';

class FlatButtonCustom extends StatelessWidget {
  final Widget destinationTo;
  final String name_button;
  final Widget icon;

  FlatButtonCustom({@required this.destinationTo, @required this.name_button,@required this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:  FlatButton(
          color: Colors.white,
          child: Container(
            // margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                icon,
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(name_button),
                )
              ],
            ),
          ),
          onPressed: () {
            context.navigateTo(destinationTo);
          }),
    );
  }
}
