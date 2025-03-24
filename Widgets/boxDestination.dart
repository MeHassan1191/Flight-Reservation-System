import 'package:flutter/material.dart';

import '../Model/flight.dart';

Flights? fl;

class BoxDestination extends StatelessWidget {
  Flights? f;


  BoxDestination({required this.f}) {
    fl = f;
    print(fl!.ticketPrice);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allow horizontal scrolling
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.22,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                _iconDestination(),
                SizedBox(width: 17),
                _originAndDestionation(),
                SizedBox(width: 70),
                _originAndDestionationIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _originAndDestionationIcon(){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(fl!.departingCity,style: TextStyle(fontSize: 25)),
      SizedBox(height: 15),
      Icon(Icons.swap_vert, color: Color(0xFFF00d5d8),size: 40),
      SizedBox(height: 15),
      Text(fl!.arrivalCity,style: TextStyle(fontSize: 25)),

    ],
  );
}

Widget _originAndDestionation(){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      RichText(
        text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: "Origin \n",
                  style: TextStyle(color: Color(0xFFFb7b7c5),fontSize: 14)
              ),
              TextSpan(text: fl!.departingCity,
                style: TextStyle(fontSize: 17,color: Colors.black),
              )
            ]
        ),
      ),

      SizedBox(height: 65),

      RichText(
        text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: "Destination \n",
                  style: TextStyle(color: Color(0xFFFb7b7c5),fontSize: 14)
              ),
              TextSpan(text: fl!.arrivalCity,
                style: TextStyle(fontSize: 17,color: Colors.black),
              )
            ]
        ),
      ),

    ],

  );

}

Widget _iconDestination(){

  return Container(
    child: Column(
      children: <Widget>[
        Icon(Icons.airplanemode_active,
            color: Color(0xFFF00d5d8),
            size: 30),

        Icon(Icons.fiber_manual_record,
            color: Color(0xFFF00d5d8),
            size: 12),
        Icon(Icons.fiber_manual_record,
            color: Color(0xFFF00d5d8),
            size: 12),
        Icon(Icons.fiber_manual_record,
            color: Color(0xFFF00d5d8),
            size: 12),
        Icon(Icons.fiber_manual_record,
            color: Color(0xFFFf89380),
            size: 12),
        Icon(Icons.fiber_manual_record,
            color: Color(0xFFFf89380),
            size: 12),
        Icon(Icons.fiber_manual_record,
            color: Color(0xFFFf89380),
            size: 12),
        Icon(Icons.location_on,
            color: Color(0xFFFf89380),
            size: 30),

      ],
    ),
  );

}
