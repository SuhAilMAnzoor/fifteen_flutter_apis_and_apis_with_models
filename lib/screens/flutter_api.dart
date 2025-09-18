import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// These Are Methods of API
// GET    >> Fetch the API
// post   >> means add karna
// GET    >> jab hum koi edit karwana hoga to
// PUT    >> Jab hum update karwana hoga to hum PUT Karenge
// POP    >> Jab hum delte karwana hoga to POP Karenge

class FlutterApi extends StatefulWidget {
  const FlutterApi({super.key});

  @override
  State<FlutterApi> createState() => _FlutterApiState();
}

class _FlutterApiState extends State<FlutterApi> {
  getPosts() async {
    //Base url                 // end-point
    var url = Uri.https('jsonplaceholder.typicode.com', '/users');
    var response = await http.get(url);
    // var responseBody = (response.body); // response.body response Data Comes in String, We need to decode/convert it
    var responseBody = jsonDecode(
      response.body,
    ); // Now Coverted into JSON fomrat But will be accessable in List<dynamic> or Map
    print(responseBody[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// If i need to Render this dats in UI We have two Options
// FutureBuilder   for that  you < return responseBody; > at the of the getPosts Function 
// ListView.builder 


// We will discuss in Next 
// Assignemt Chat Application 