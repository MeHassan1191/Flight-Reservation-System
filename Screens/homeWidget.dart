import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/Flight%20Reservation%20System/Admin%20Side/Global/LoggedIn.dart';

import '../API/Api.dart';
import '../Model/flight.dart';
import '../Model/user.dart';
import '../Widgets/boxDestination.dart';
import '../Widgets/options.dart';
import '../Widgets/recommendation.dart';
import '../Widgets/selectOptions.dart';
import '../Widgets/selectWay.dart';
import 'MainScreen.dart';
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final APIHandler apiHandler = APIHandler(); // Instantiate your API handler

  List<Flights> flightss = [];
  List<Flights> myFlights = [];
  User? u;
  ImageProvider<Object>? userImage;
  bool hasImage=false;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
    try {
      List<Flights> fetchedFlights = await apiHandler.getAllFlights();
      List<Flights> myF=await apiHandler.getFlightsForUser(LoggedIn);
      setState(() {
        flightss = fetchedFlights;
        myFlights=myF;

        fetchImage();

      });
    } catch (error) {
      print('Error fetching flights: $error');
    }
  }
  Future<void> fetchImage() async {
    try {
      List<int> imageBytes = await apiHandler.getUserImage(LoggedIn);
      if (imageBytes.isNotEmpty) {
        setState(() {
          String base64String = base64Encode(imageBytes);
          // Update your state or perform any other action with the fetched image data
          userImage = NetworkImage("${APIHandler.imgr_url}$LoggedIn.jpg");
          print('Image Found');
          hasImage=true;
        });
      } else {
        // Handle case where image is not found
        print("User image not found");
      }
    } catch (error) {
      // Handle error, for example, show an error message
      print("Error fetching image: $error");
    }
    if(!hasImage)
      userImage= AssetImage('lib/assets/img_2.png');
  }



  Future<void> getById() async {

      if (LoggedIn != null) {
        print(LoggedIn);
        List<User> fetchedUsers = await apiHandler.getAllUsers();
        print("l1 ${fetchedUsers.length}");
        User? u = fetchedUsers.firstWhere((element) => element.userId == LoggedIn);

        if (u != null) {
          myFlights = flightss.where((element) => element.flightId == u.flightId).toList();
          print('Length ${myFlights.length}');
          setState(() {
            this.u = u;

          });
        } else {
          print('User with userId $LoggedIn not found');
        }
      } else {
        print('LoggedIn is null');
      }


  }
  File? _selectedImage;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<File?>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Image Source'),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context, await _getImage(ImageSource.camera));
              },
              child: const Text('Camera'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context, await _getImage(ImageSource.gallery));
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });


      APIHandler apiHandler = APIHandler();
      int statusCode = await apiHandler.uploadProfilePic(LoggedIn, pickedImage);

      if (statusCode == 200) {
        print('Profile picture uploaded successfully');
        setState(() {

        });
      } else {
        print('Failed to upload profile picture. Status code: $statusCode');
      }
    }
  }
  Future<File?> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 500,
      maxHeight: 500,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }
  TextEditingController search=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFf6f5fb),
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green, // Set the background color
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: userImage,
                  ),),

                  Positioned(
                    bottom: 10,
                    right: 79,
                    child: IconButton(
                      color:Colors.blue,
                      icon: Icon(Icons.camera),

                      onPressed: _selectImage,


                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.exit_to_app, color: Colors.black), // Add icon to the right

              titleAlignment: ListTileTitleAlignment.center,// Set text color
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyApp1(),
                  ),
                );
                LoggedIn='';
              },

            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor:Colors.green,
        title: TextField(
          controller: search,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  if(search.text!=null){
                    List<Flights> isFound=flightss.where((element) => element.departingCity==search.text||element.arrivalCity==search.text).toList();
                    if(isFound.isNotEmpty){
                      flightss=isFound;
                    }
                  }
                });
              },
              child: Icon(
                Icons.search
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image.asset(
                  'lib/assets/img.png', // Replace with your dummy image
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 30, top: 40, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Options(),
                SizedBox(height: 20),
                if (myFlights.length > 0)
                  Column(
                    children: [
                      for (int j = 0; j < myFlights.length; j++)
                        Column(
                          children: [
                            new BoxDestination(f: myFlights[j]),
                            SizedBox(height: 10,),
                            new SelectOptions(f: myFlights[j]),
                            SizedBox(height: 10,)
                          ],
                        ),
                    ],
                  )

                ,SizedBox(height: 22),
                SelectWay(),
                SizedBox(height: 25),
                SizedBox(height: 16),


                  Recommendation(flist: flightss),
              ],
            ),
          ),
        ),
      ),

    );
  }
}