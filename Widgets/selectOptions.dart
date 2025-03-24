
import 'package:flutter/material.dart';

import '../Components/btnPassengers.dart';
import '../Model/flight.dart';
Flights? fl;
class SelectOptions extends StatelessWidget {
  Flights? f;
  SelectOptions({required this.f}){
    fl=f;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              BtnPassengers(
                title: "Departure",
                label: fl!.departureTime,
                color: Color(0xFFFfeb578),
                iconData: Icons.today,
              ),
              BtnPassengers(
                title: "Arrival",
                label: fl!.arrivalTime,
                color: Color(0xFFF00d5d8),
                iconData: Icons.today,
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              BtnPassengers(
                title: "Flight No",
                label: fl!.flightId,
                color: Color(0xFFFfe8db9),
                iconData: Icons.wc,
              ),
              BtnPassengers(
                title: "Ticket Price",
                label: fl!.ticketPrice,
                color: Color(0xFFF7d59ee),
                iconData: Icons.today,
              )
            ],
          )
        ],
      ),
    );
  }
}