import 'dart:convert';
import 'package:fifteen_flutter_apis/models/best_postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Without Listview.builder,
// With For Loop but Map function is also used in ListTile
class FlutterApiFivePostModel extends StatefulWidget {
  const FlutterApiFivePostModel({super.key});

  @override
  State<FlutterApiFivePostModel> createState() =>
      _FlutterApiFivePostModelState();
}

class _FlutterApiFivePostModelState extends State<FlutterApiFivePostModel> {
  // We use Future<List<PostModel>> to specify that we expect a list of PostModel objects, in this if you not define the type it will throw the error of Type List <Widget>
  Future<List<PostModel>> getPosts() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    // convert each item to PostModel
    List<PostModel> allPosts = [];
    for (var eachpostfromJson in responseBody) {
      allPosts.add(PostModel.fromJson(eachpostfromJson));
    }
    return allPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PostModel>>(
        future: getPosts(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<PostModel>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Data is being loaded"),
                  Text("Please wait..."),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            // Using ListView for rendering all posts instead of ListView.builder
            return ListView(
              children:
                  snapshot.data!.map((post) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Text("${post.id}"),
                      ),
                      title: Text(
                        post.title.isEmpty ? "NO Title!" : post.title,
                      ),
                      subtitle: Text(post.body),
                    );
                  }).toList(),
            );
          }

          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}
