import 'package:flutter/material.dart';
import '../Model/flight.dart';
Flights? f;
class RecommendationItem extends StatelessWidget {

  final String? title;
  final String? price;
  final Color? color;
  final Flights? flight;
  final void Function()? onTap;

  RecommendationItem({Key? key,this.title,this.price, this.color, this.onTap,this.flight  }) : super(key: key)
  {
    f=flight;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 400,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
                Radius.circular(14)
            )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _icon(color!),
            SizedBox(height: 16),
            Text(title!, style: TextStyle(color: Colors.white)),
            SizedBox(height: 14),
            _destination(),
            SizedBox(height: 10),
            _price(price!)


          ],
        ),
      ),
    );
  }
}

Widget _price(String price){

  return Container(
    child: Row(
      children: <Widget>[
        Text(price,style: TextStyle(color: Colors.white,fontSize: 25)),
        SizedBox(width: 20),
        Icon(Icons.trending_flat,size: 32,color: Colors.white)
      ],
    ),
  );

}

Widget _destination(){
  return Container(
    child: Row(
      children: <Widget>[
        Text(f!.departingCity,
            style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold)),
        SizedBox(width: 10),
        Icon(Icons.swap_horiz,size: 32,color: Colors.white),
        SizedBox(width: 10),
        Text(f!.arrivalCity,
            style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _icon(Color color){

  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(10)
        )
    ),

    child: Icon(Icons.flight_takeoff,color: color,size: 32),
  );

}