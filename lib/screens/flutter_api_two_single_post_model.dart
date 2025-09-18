import 'dart:convert';
// Flutter API Two Through Model, This model is only for single post not for all posts
// Follow post_model.dart in models folder
import 'package:fifteen_flutter_apis/models/single_post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlutterApiTwoSinglePostModel extends StatefulWidget {
  const FlutterApiTwoSinglePostModel({super.key});

  @override
  State<FlutterApiTwoSinglePostModel> createState() =>
      _FlutterApiTwoSinglePostModelState();
}

class _FlutterApiTwoSinglePostModelState
    extends State<FlutterApiTwoSinglePostModel> {
  //i can also define getPosts() function type now that is Future<SinglePostModel> getPost()...
  // i determined this at the end of run time
  Future<SinglePostModel> getPosts() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts/1');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    SinglePostModel post = SinglePostModel.fromJson(responseBody);
    print(post.runtimeType);
    SinglePostModel post2 = SinglePostModel.fromJson(responseBody);
    print(post2.runtimeType);
    print("$post + ${post2}");
    return post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPosts(),
        builder: ((
          BuildContext context,
          AsyncSnapshot<SinglePostModel> snapshot,
        ) {
          if (snapshot.hasData) {
            // In previous we used ListView.Builder but now we dont need of it, after Post Model implementation
            return ListTile(
              // Use ! if you are 100% sure that data will be null or have respone of API  // This Topic is related Null Safety
              leading: CircleAvatar(child: Text("${snapshot.data!.id!}")),
              title: Text(snapshot.data!.title!),
              subtitle: Text(snapshot.data!.body!),
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
