import 'dart:convert';
import 'package:fifteen_flutter_apis/models/best_postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Follow best_postModel.dart  => New
// Same Code continues and follow a new Model with it have changes in UI

class FlutterApiFourPostModelRecommended extends StatefulWidget {
  const FlutterApiFourPostModelRecommended({super.key});

  @override
  State<FlutterApiFourPostModelRecommended> createState() =>
      _FlutterApiOneThroughNewPostModelRecommendedState();
}

class _FlutterApiOneThroughNewPostModelRecommendedState
    extends State<FlutterApiFourPostModelRecommended> {
  // We use Future<List<PostModel>> to specify that we expect a list of PostModel objects
  // Recommended give the type of getPosts() function
  getPosts() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body); // Handling

      // Use map to convert each item to PostModel
      return (responseBody as List)
          .map(
            (json) => PostModel.fromJson(json),
          ) // here we can also use for in loop
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //Before < ( > Recommened the define the type of , <List<PostModel>> ,
        // also inside the Builder Between AysncSnaphot <List<PostModel>> snapshot
        future: getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            // Use ListView.builder to display multiple posts
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var post = snapshot.data[index];
                return ListTile(
                  leading: CircleAvatar(child: Text("${post.id}")),
                  title: Text(
                    post.title.isEmpty ? "No Title Provided" : post.title,
                  ),
                  subtitle: Text(post.body),
                );
              },
            );
          }

          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}
