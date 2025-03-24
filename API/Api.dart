import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Model/WhoIsLoggingIn.dart';
import '../Model/flight.dart';
import '../Model/user.dart';
class APIHandler
{
  String base_url='http://192.168.10.7/Api/FRS';

  static String imgr_url='http://192.168.10.7/Content/Profimages/';

  Future<int> signup(User u) async {
    String url = base_url + "/Signup";

    var jsonData = jsonEncode(u);
    Uri uri = Uri.parse(url);
    var response = await http.post(
      uri,
      body: jsonData,
      headers: {
        "Content-Type": "application/json; charset=utf-8", // Fix: use "utf-8" instead of "UTF8"
      },
    );

    return response.statusCode;
  }

  Future<http.Response> login(String id,String pass)async
  {
    String url="${base_url}/Login?id=$id&pass=$pass";
    Uri uri=Uri.parse(url);
    //Uri uri=Uri.https('localhost:58489', 'Api/FRS/Login?id=$id&pass=$pass');
    var response =await  http.get(uri);
    return response;

  }
  Future<List<Flights>> getAllFlights() async {
    List<Flights> flights = [];
    String url = "$base_url/GetAllFlights";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('200');

        final List<dynamic> flightListJson = json.decode(response.body);
        flights = flightListJson.map((json) => Flights.fromJson(json)).toList();
      } else if (response.statusCode == 204) {

        print('No Flights Available');
      } else {
        // If the server returns any other status code, handle accordingly
        print('Failed to get flights. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or server errors
      print('An error occurred: $error');
    }

    return flights;
  }
  Future<Flights?> getFlightById(String flightId) async {
    String url = '$base_url/GetFlightById?flightId=$flightId';
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Decode the response body into a Flight object
        final Map<String, dynamic> flightJson = json.decode(response.body);
        final Flights flight = Flights.fromJson(flightJson);

        return flight;
      } else if (response.statusCode == 404) {
        // Flight not found
        print('Flight not found');
        return null;
      } else {
        // If the server returns any other status code, handle accordingly
        print('Failed to get flight. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle network or server errors
      print('An error occurred: $error');
      return null;
    }
  }
  Future<Map<String, dynamic>> addFlight(Flights flight) async {
    final String apiUrl = "$base_url/addFlight";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(flight),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Handle error cases
        print("Failed to add flight. Status code: ${response.statusCode}");
        return {"error": "Failed to add flight"};
      }
    } catch (error) {
      print("An error occurred: $error");
      return {"error": "An error occurred"};
    }
  }
  FutureOr<person?> LoggingIn(String id, String pass) async {
    String url = "$base_url/Login?id=$id&pass=$pass";
    Uri uri = Uri.parse(url);

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        final per = jsonDecode(response.body);
        print(per);
        person p = person.fromJson(per);
        print("${p.id},${p.isAdmin}");
        return p;
      } else if (response.statusCode == 204) {
        print('Wrong UN or Password');
        return null;
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
        // Handle other error cases if needed
        return null;
      }
    } catch (error) {
      print('An error occurred: $error');
      // Handle network or other errors
      return null;
    }
  }


  Future<int> addFlightForUser(String userId, String flightNo) async {

    String url = "$base_url/AddFlightForUser?userId=$userId&flightNo=$flightNo";
    print('Flight No:$flightNo , User_Id:$userId');

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        // Flight added successfully

        print("Flight added for the user successfully");
        return 1;
      } else if (response.statusCode == 404) {
        // User or Flight not found
        print("User or Flight not found,${response.body}");
        return 0;
      } else {
        // Other errors
        print("Failed to add flight for the user");
        return 0;
      }
    } catch (error) {
      print("Error: $error");
      return 0;
    }
  }

  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse('$base_url/GetAllUsers'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<User> users = jsonResponse.map((data) => User.fromJson(data)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<int> uploadProfilePic(String userId, File image) async {
    String url=base_url+"/AddImageForUser";
    Uri uri=Uri.parse(url);
    http.MultipartRequest request=http.MultipartRequest('POST',uri);

    //request.fields.addAll({"nic":nic});
    request.fields["userId"]=userId;
    http.MultipartFile imgfile=await http.MultipartFile.
    fromPath("image", image.path);
    request.files.add(imgfile);
    var streamresponse= await request.send();
    http.Response res= await http.Response.fromStream(streamresponse);
    print('${res.body}');
    return res.statusCode;
  }

  Future<List<int>> getUserImage(String userId) async {
    String url = "$base_url/GetUserImage?userId=$userId";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Return the image bytes as a list of integers
        List<int> imageBytes = response.bodyBytes;
        return imageBytes;
      } else if (response.statusCode == 404) {
        // Image not found
        print("User image not found");
        return [];
      } else {
        // Other errors
        print("Failed to get user image. Status code: ${response.statusCode},${response.body}");
        return [];
      }
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }
  // Add the following method to your APIHandler class
  Future<List<Flights>> getFlightsForUser(String userId) async {
    String url = "$base_url/GetReservationsForUser?userId=$userId";
    print(url);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the response body into a list of Flight objects
        List<dynamic> flightListJson = json.decode(response.body);
        List<Flights> flights = flightListJson.map((json) => Flights.fromJson(json)).toList();
        for(int i=0;i<flights.length;i++)
          print(flights[i].flightId);
        return flights;
      } else if (response.statusCode == 204) {
        // No flights available for the user
        print('No Flights Available for the user');
        return [];
      } else {
        // If the server returns any other status code, handle accordingly
        print('Failed to get flights for the user. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle network or server errors
      print('An error occurred: $error');
      return [];
    }
  }


}