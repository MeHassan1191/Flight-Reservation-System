import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:untitled1/Flight%20Reservation%20System/API/Api.dart';
import 'package:untitled1/Flight%20Reservation%20System/Admin%20Side/plane_curve.dart';


import '../Model/flight.dart';
import 'Global/Flight_id.dart';
import 'constants.dart';
import 'detail.dart';
// import 'package:barcode_flutter/barcode_flutter.dart';

class DetailScreen extends StatefulWidget {
  static String id = 'detail_screen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Flights? flight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFlight();

  }
  Future<void> getFlight() async {
    APIHandler a=APIHandler();
    flight=await a.getFlightById(flightId);
    print(flight!.arrivalCity);
    print("Flight Id"+flightId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.001),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Row(
                        children: <Widget>[
                          backbutton(),
                          Spacer(),
                          profileimg(),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: pickedflight(),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.034),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ClipPath(
                        clipper: DetailClipper(radius: 10.0),
                        child: Material(
                          elevation: 4.0,
                          shadowColor: Color(0x30E5E5E5),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: ClipPath(
                            clipper: DetailClipper(radius: 12.0),
                            child: Card(
                              elevation: 2.0,
                              margin: EdgeInsets.all(2.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: _buildCardContent(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backbutton() {
    return IconButton(
      icon: Icon(Icons.arrow_circle_left),
      onPressed: () => Navigator.pop(context),
      color: Colors.white,
      iconSize: 30.0,
    );
  }

  Widget profileimg() {
    return Card(
      //color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(13.0),
          bottomRight: Radius.circular(12.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

      ),
    );
  }

  Widget pickedflight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DBC',
                style: TextStyle(
                  fontFamily: 'Sofia Pro',
                  color: kFloatingButton,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Dabaca',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sofia Pro',
                  fontSize: 10.0,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w300,
                  height: 2.0,
                ),
              ),
            ],
          ),
        ),
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
              '1hr 35m',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                height: 1.5,
              ),
            ),
          ],
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                flight!.departingCity,
                style: TextStyle(
                  fontFamily: 'Sofia Pro',
                  color: kFloatingButton,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                flight!.departingCity,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sofia Pro',
                  fontSize: 10.0,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w300,
                  height: 2.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildCardContent() {

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 1.0, left: 7.0, bottom: 5.0),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, bottom: 5.0),
                    child: Icon(Icons.airplanemode_active_outlined,
                        size: 23.0, color: kFloatingButton),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                      child: Text('Ticket Price', style: kTextStyle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: Offset(5, -4),
                              child: Text(
                                '\$',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: kMainColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '\t${flight!.ticketPrice}',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: kMainColor,
                              fontSize: 23.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 0.0),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 29.0, right: 45.0, bottom: 5.0),
            child: Divider(
              color: kTextColor,
              thickness: 0.3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(
                    color: kMainColor,
                    width: 1,
                    style: BorderStyle.none,
                  ),
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Center(
                              child: Text(
                        'FLIGHT Departure',
                        style: kTextStyle,
                      ))),
                      TableCell(
                        child: Center(
                            child: Text(
                          'Flight Arrival',
                          style: kTextStyle,
                        )),
                      ),
                      TableCell(
                          child: Center(
                              child: Text(
                        'FLIGHT NO',
                        style: kTextStyle,
                      ))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Align(
                              alignment: Alignment(-0.3, 0),
                              child: Text(
                                flight!.departureTime,
                                style: kTableBold,
                              ))),
                      TableCell(
                        child: Align(
                            alignment: Alignment(-0.1, 0),
                            child: Text(
                              flight!.arrivalTime,
                              style: kTableBold,
                            )),
                      ),
                      TableCell(
                        child: Align(
                            alignment: Alignment(-0.3, 0),
                            child: Text(
                              flight!.flightId,
                              style: kTableBold,
                            )),
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Table(
                  border: TableBorder.all(
                    color: kMainColor,
                    width: 1,
                    style: BorderStyle.none,
                  ),
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Align(
                        alignment: Alignment(0.5, 0),
                        child: Text(
                          'Arrival TIME',
                          style: kTextStyle,
                        ),
                      )),
                      TableCell(
                        child: Align(
                          alignment: Alignment(-0.1, 0),
                          child: Text(
                            'Arrival City',
                            style: kTextStyle,
                          ),
                        ),
                      ),
                      TableCell(
                          child: Align(
                        alignment: Alignment(-0.3, 0),
                        child: Text(
                          '',
                          style: kTextStyle,
                        ),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Align(
                              alignment: Alignment(-0.3, 0),
                              child: Text(
                                flight!.arrivalTime,
                                style: kTableBold,
                              ))),
                      TableCell(
                        child: Align(
                            alignment: Alignment(-0.1, 0),
                            child: Text(
                              flight!.arrivalCity,
                              style: kTableBold,
                            )),
                      ),
                      TableCell(
                        child: Align(
                            alignment: Alignment(-0.0, 0),
                            child: Text(
                              '',
                              style: kTableBold,
                            )),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          DottedLine(
            dashColor: kMainColor,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text('Boarding pass', style: kTableBold),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        ],
      ),
    );
  }
}
