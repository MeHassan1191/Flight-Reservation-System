import 'package:flutter/material.dart';
import 'package:untitled1/Flight%20Reservation%20System/Admin%20Side/plane_curve.dart';

import '../API/Api.dart';
import '../Model/flight.dart';
import 'Global/Flight_id.dart';
import 'constants.dart';
import 'detail-screen.dart';

class Flight extends StatefulWidget {
  @override
  _FlightState createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  final APIHandler apiHandler = APIHandler();  // Instantiate your API handler

  List<Flights> flightss = [];
  final List<DisplayFlight> flights=[];

  @override
  void initState() {
    super.initState();
    fetchFlights();
    setState(() {

    });
    // Fetch flights when the widget is initialized
  }


  Future<void> fetchFlights() async {
    try {
      List<Flights> fetchedFlights = await apiHandler.getAllFlights();
      setState(() {
        flightss = fetchedFlights;
      });
      setAllFlights();
    } catch (error) {
      print('Error fetching flights: $error');
    }
  }
  void setAllFlights(){
    for(int i=0;i<flightss.length;i++){
      flights.add(DisplayFlight(startCountryAb: flightss[i].departingCity,
          startCountryName: flightss[i].departingCity,
          destinationAb: flightss[i].arrivalCity,
          destinationName: flightss[i].arrivalCity,
          arrivalTime: flightss[i].arrivalTime,
          departingTime: flightss[i].departureTime,
          flightNumber: flightss[i].flightId));
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 40.0),
      child: Column(
        children: <Widget>[
          for (DisplayFlight displayFlight in flights)
            GestureDetector(
              child: fullFlightList(displayFlight),
              onTap: () {
                flightId=displayFlight.flightNumber;

              },
            ),
        ],
      ),
    );
  }



  Widget fullFlightList(DisplayFlight displayFlight) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    displayFlight.startCountryAb,
                    style: kCountryAbText,
                  ),
                  Text(
                    displayFlight.startCountryName,
                    style: kCountryName,
                  ),
                  SizedBox(height: 28.0),
                  Text(
                    'Time',
                    style: kFlightDate,
                  ),
                  Text(
                    displayFlight.departingTime,
                    style: kFlightDateDisplay,
                  ),
                ],
              ),
            ),
            // SizedBox(width: 6.0),
            Column(
              children: <Widget>[
                CustomPaint(
                  painter: PlaneCurved(bodyColor: kFloatingButton, width: 0.2),
                  child: Container(
                    //height: 0.0,
                    width: 48.0,
                    child: Icon(
                      Icons.airplanemode_active_outlined,
                      color: kFloatingButton,
                    ),
                  ),
                ),
                Text(
                  displayFlight.departingTime,
                  style: kFlightDateDisplay,
                ),
              ],
            ),
            //Spacer(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    displayFlight.destinationAb,
                    style: kCountryAbText,
                  ),
                  Text(
                    displayFlight.destinationName,
                    style: kCountryName,
                  ),
                  SizedBox(height: 28.0),
                  Text(
                    'FLIGHT NO',
                    style: kFlightDate,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      displayFlight.flightNumber,
                      style: kFlightDateDisplay,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Divider(
          color: kFloatingButton,
          thickness: 0.2,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
      ],
    );
  }
}



class DisplayFlight {
  final String startCountryAb;
  final String startCountryName;
  final String destinationAb;
  final String destinationName;
  final String departingTime;
  final String flightNumber;
  final String arrivalTime;

  DisplayFlight(
      {required this.startCountryAb,
        required this.startCountryName,
        required this.destinationAb,
        required this.destinationName,
        required this.arrivalTime,
        required this.departingTime,
        required this.flightNumber});
}
