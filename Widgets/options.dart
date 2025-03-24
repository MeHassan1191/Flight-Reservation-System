
import 'package:flutter/material.dart';

import '../Components/btnOptions.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          BtnOptions(
            label: "Flights",
            color: Color(0xFFFf89380),
          )
        ],
      ),
    );
  }
}