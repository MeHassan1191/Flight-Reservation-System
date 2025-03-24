import 'package:flutter/material.dart';

import 'MainScreen.dart';

class S_Screen extends StatefulWidget {
  const S_Screen({super.key});

  @override
  State<S_Screen> createState() => _S_ScreenState();
}

class _S_ScreenState extends State<S_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey, // Add a background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              foregroundImage: AssetImage('lib/assets/img.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Flight Reservation System',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while waiting
                  return Text('Loading...', style: TextStyle(fontSize: 16));
                } else {
                  // Navigate after the delay
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyApp1(),
                      ),
                    );
                  });
                  // Display some content while waiting (optional)
                  return Text('Loading...', style: TextStyle(fontSize: 16));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
