import 'package:flutter/material.dart';
import 'package:untitled1/Flight%20Reservation%20System/API/Api.dart';
import 'package:untitled1/Flight%20Reservation%20System/Screens/MainScreen.dart';
import 'package:http/http.dart' as http;

import '../Model/user.dart';

class SignUpS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Reservation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final APIHandler apiHandler = APIHandler();

  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController cpass = TextEditingController();

  String? gender = 'Male', day, month, year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/img_1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: name,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: cnic,
                  decoration: InputDecoration(
                    labelText: 'CNIC',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Gender:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(value: 'Male', groupValue: gender, onChanged: (val)
                    {

                      gender=val!;
                      setState(() {

                      });

                    }),
                    Text('Male'),
                    Radio(value: 'Female', groupValue: gender, onChanged:  (val){gender=val!;setState(() {

                    });}),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Date of Birth:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      items: List.generate(31, (index) => index + 1)
                          .map((day) => DropdownMenuItem<int>(
                        value: day,
                        child: Text(day.toString()),
                      ))
                          .toList(),
                      onChanged: (value) {day=value!.toString();},
                      hint: Text('Day'),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      items: [
                        'January', 'February', 'March', 'April', 'May', 'June',
                        'July', 'August', 'September', 'October', 'November', 'December'
                      ]
                          .map((month) => DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      ))
                          .toList(),
                      onChanged: (value) {month=value!;},
                      hint: Text('Month'),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      items: List.generate(100, (index) => 2024 - index)
                          .map((year) => DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      ))
                          .toList(),
                      onChanged: (value) {year=value.toString();},
                      hint: Text('Year'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: id,
                  decoration: InputDecoration(
                    labelText: 'User Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: cpass,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String username = id.text;
                    String password = pass.text;
                    String Dob = "$day:$month:$year";
                    String Gender = gender!;
                    User u = User(
                      userId: username,
                      userName: name.text,
                      password: pass.text,
                      dateOfBirth: Dob,
                      gender: Gender,
                      image: '',
                      flightId: '',
                    );

                    int response = await apiHandler.signup(u);
                    print(response);

                    if (response == 201) {
                      if (pass.text == cpass.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReservationScreen()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Passwords are not the same'),
                            );
                          },
                        );
                        print('Passwords are not the same');
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign up Failed'),
                          );
                        },
                      );
                      print('Sign up failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
