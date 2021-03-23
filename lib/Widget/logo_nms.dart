import 'package:flutter/material.dart';
import '../Common/common.dart' as Common;


class WidgetLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'N',
                style: TextStyle(
                    fontSize: Common.titleSize,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'M',
                style: TextStyle(
                    fontSize: Common.titleSize,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'S',
                style: TextStyle(
                    fontSize: Common.titleSize,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(
          'Services for The Next Genertion',
          style: TextStyle(
              color: Colors.blue[900],
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }


}