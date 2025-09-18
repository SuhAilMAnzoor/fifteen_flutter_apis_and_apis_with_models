import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Render IN UI Using FutureBuilder
class FlutterApiOne extends StatefulWidget {
  const FlutterApiOne({super.key});

  @override
  State<FlutterApiOne> createState() => _FlutterApiOneState();
}

class _FlutterApiOneState extends State<FlutterApiOne> {
  getPosts() async {
    // you can define its type before getPosts like this Future<List<dyamic>> getPosts
    var url = Uri.https('jsonplaceholder.typicode.com', '/users');
    var response = await http.get(url);
    var responseBody = jsonDecode(
      response.body,
    ); // Now coverted/decoded json formted into dart object like in List<dynamic> or Map
    return responseBody; // to get access this converted data in futureBuilder we need to return this data,
    // that is in List<dynamic>
    // now we have data in List<dynamic format>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPosts(), // called Function to fetch the data from API
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          //set AsyncSnapshot snapshot to tell future builder that this is not normal Snapshot
          // it is waiting for future , like here we are fetching from API not internal
          if (snapshot.hasData) {
            // print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    // Direct API implemented using Listview.Builder and Listtile inside the FutureBuilder
                    // But this is not better way to define APIs in Code and Reusibilty you works but this is not good approch.
                    child: Text("${snapshot.data[index]['id']}"),
                  ),
                  title: Text(snapshot.data[index]['name']),
                  subtitle: Text(snapshot.data[index]['email']),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}

// This is not good way to integrate API like static way
// This is Chalo Tareeqa
