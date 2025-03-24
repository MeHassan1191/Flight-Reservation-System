import 'package:flutter/material.dart';
import 'package:untitled1/Flight%20Reservation%20System/Admin%20Side/title.dart';
import 'package:untitled1/Flight%20Reservation%20System/Screens/SplashScreen.dart';

import 'add_flight_screen.dart';
import 'constants.dart';
import 'flight.dart';
import 'header.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  final Header header;
  HomePage({Key? key, required this.header}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _profilePictureAnimation;
  late Animation _contentAnimation;
  late Animation _listAnimation;
  late Animation _fabAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));


    _contentAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.20, 0.40, curve: Curves.easeOut)));

    _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.40, 0.75, curve: Curves.easeOut)));

    _fabAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.75, 1.0, curve: Curves.easeOut)));

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.airplanemode_active,
                    color: Colors.white,
                    size: 64.0,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Airplane App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout logic here
                Navigator.pop(context); // Close the drawer
                // Add your logout logic here (e.g., navigate to login screen, clear user session, etc.)
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                Transform.scale(
                    scale: _contentAnimation.value,
                    child: HeadTitle(title: 'My flights')),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _buildSheet(),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                // Handle logout logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => S_Screen()),
                );// Close the drawer
                // Add your logout logic here (e.g., navigate to login screen, clear user session, etc.)
              },
              tooltip: 'Logout',
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      floatingActionButton: Transform.scale(
        scale: _fabAnimation.value,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 35.0,
            color: kMainColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddFlightScreen.id);
          },
          tooltip: 'Add new tasks',
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          backgroundColor: kFloatingButton,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  Widget _buildSheet() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        child: Opacity(opacity: _listAnimation.value, child: Flight()),
      ),
    );
  }
}
