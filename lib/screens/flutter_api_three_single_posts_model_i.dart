import 'package:fifteen_flutter_apis/models/single_post_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Flutter API One Through Posts Model - Two File  - > Multiple Posts
// Prevous Was Only Accessing One Post, Class File
// In this Complete Posts Will be Accessed with the help of for Loop
// Followed Same post_model.dart  |  No Changes i made for this class file
class FlutterApiThreePostModel extends StatefulWidget {
  const FlutterApiThreePostModel({super.key});

  @override
  State<FlutterApiThreePostModel> createState() =>
      _FlutterApiThreePostModelState();
}

class _FlutterApiThreePostModelState extends State<FlutterApiThreePostModel> {
  //we can also define getPosts() function type now that is changed from Prevoius one now,  Future<SinglePostModel> getPost()...
  // i determined this at the end of run time in prevoius class file
  Future<List<SinglePostModel>> getPostsApi() async {
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
        future: getPostsApi(),
        builder: ((
          BuildContext context,
          AsyncSnapshot<List<SinglePostModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children:
                  data.map((post) {
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
