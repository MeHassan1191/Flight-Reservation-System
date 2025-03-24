import 'package:flutter/material.dart';

import '../Components/recommendationItem.dart';
import '../Model/flight.dart';
import '../Screens/reservations.dart';

class Recommendation extends StatelessWidget {
  List<Flights>? flist;

  Recommendation({required this.flist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Other Flights", style: TextStyle(color: Colors.black, fontSize: 20)),
        SizedBox(height: 14),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: flist!.length,
            itemBuilder: (context, index) {
              return RecommendationItem(
                title: flist![index].departingCity,
                price: flist![index].ticketPrice,
                flight: flist![index],

                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Reservations(flight: flist![index],)),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
