
import 'package:flutter/material.dart';

import '../Components/btnWay.dart';

class SelectWay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              BtnWay(
                label: "Flights",
                iconData: Icons.trending_flat,
                color: Color(0xFFFababbc),
              )
            ],
          )
        ],
      ),
    );
  }
}