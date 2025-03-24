
import 'package:flutter/material.dart';
import 'package:untitled1/Flight%20Reservation%20System/API/Api.dart';
import 'package:untitled1/Flight%20Reservation%20System/Admin%20Side/Global/LoggedIn.dart';
import 'package:untitled1/Flight%20Reservation%20System/Model/flight.dart';

import 'homeWidget.dart';
Flights? f;
class Reservations extends StatefulWidget {

  final Flights flight;

  Reservations({Key? key, required this.flight}) : super(key: key)
  {
    f=flight;
  }

  @override
  _ReservationsState createState() => _ReservationsState();
}
late BuildContext storedContext;
class _ReservationsState extends State<Reservations> {


  @override
  Widget build(BuildContext context) {
    storedContext = context;
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),

                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.keyboard_backspace, color: Colors.white,size: 25),
                          SizedBox(width: 40),
                          Text(f!.departingCity,
                              style: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Icon(Icons.swap_horiz,color: Colors.white,size: 25),
                          SizedBox(width: 10),
                          Text(f!.arrivalCity,
                              style: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.bold)),

                          SizedBox(width: 160),
                          Icon(Icons.build,color: Colors.white,size: 25)
                        ],
                      ),
                      SizedBox(height: 13),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(f!.arrivalTime,
                              style: TextStyle(color: Colors.white,fontSize: 15)),
                          Text(f!.arrivalTime,
                              style: TextStyle(color: Colors.white,fontSize: 15))
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  decoration: BoxDecoration(
                      color: Color(0xFFFf6f5fb),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      )
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Flight Details",
                              style: TextStyle(fontSize: 25)),
                          Icon(Icons.filter_list, color: Colors.black,size: 25)
                        ],
                      ),

                      SizedBox(height: 30),

                      Container(
                        height: 500,
                        child: ListView(
                          children: <Widget>[
                            _reservationsItem(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
Widget _reservationsItem() {
  return Container(
    width: 500,
    height: 250,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.motorcycle, color: Colors.orange, size: 32),
                SizedBox(width: 15),
                Text("Airways",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                SizedBox(width: 60),Icon(Icons.monetization_on_sharp, color: Colors.orange, size: 20),
                SizedBox(width: 10),
                Text("${f!.ticketPrice}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _itemDepartment(),
                _locationPlane(),
                _itemDepartment2(),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: ()
              async {
                APIHandler a = APIHandler();
                var res = await a.addFlightForUser(LoggedIn, f!.flightId);

                if (res == 1) {
                  print('Reserved');
                  showDialog(
                    context: storedContext,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Reserved'),
                      );
                    },
                  );

                  Navigator.pushReplacement(
                    storedContext,
                    MaterialPageRoute(builder: (context) => HomeWidget()),
                  );

                } else {
                 print('S W R');
                }
              },
              child: Text("Reserve"),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget _itemDepartment(){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Departure", style: TextStyle(color: Colors.black54)),
        SizedBox(height: 10),
        Text(f!.departureTime, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        SizedBox(height: 1),
        Text(f!.departingCity, style: TextStyle(color: Colors.black54)),

      ],
    ),
  );
}

Widget _itemDepartment2(){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Arrive", style: TextStyle(color: Colors.black54)),
        SizedBox(height: 20),
        Text(f!.arrivalTime, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        SizedBox(height: 1),
        Text(f!.arrivalCity, style: TextStyle(color: Colors.black54)),
      ],
    ),
  );
}

Widget _locationPlane(){
  return Container(
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flight_takeoff, color: Colors.blue,size: 21),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.location_on, color: Colors.blue,size: 21),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: Colors.blue,size: 21),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.blue,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.fiber_manual_record,color: Colors.green,size: 8),
            Icon(Icons.flight_takeoff, color: Colors.blue,size: 21),
          ],
        )
      ],
    ),
  );
}