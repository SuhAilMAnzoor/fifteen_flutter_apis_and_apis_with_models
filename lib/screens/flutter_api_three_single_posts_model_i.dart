import 'package:fifteen_flutter_apis/models/single_post_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Flutter API Three Through Single Post Model -> Multiple Posts
// In prevous file i was only accessing one post,
// In this, all Posts will be fetched and accessed with the help of for Loop
// Follow Same single_post_model.dart, i have nothing changed in this model
class FlutterApiThreePostModel extends StatefulWidget {
  const FlutterApiThreePostModel({super.key});

  @override
  State<FlutterApiThreePostModel> createState() =>
      _FlutterApiThreePostModelState();
}

class _FlutterApiThreePostModelState extends State<FlutterApiThreePostModel> {
  Future<List<SinglePostModel>> getPosts() async {
    List<SinglePostModel> allPosts = [];
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      allPosts.add(SinglePostModel.fromJson(i));
    }
    return allPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPosts(),
        builder: ((
          BuildContext context,
          AsyncSnapshot<List<SinglePostModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView(
              children:
                  snapshot.data!.map((post) {
                    return ListTile(
                      leading: CircleAvatar(child: Text("${post.id}")),
                      title: Text(post.title ?? "No Title"),
                      subtitle: Text(post.body ?? "No Body"),
                    );
                  }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
