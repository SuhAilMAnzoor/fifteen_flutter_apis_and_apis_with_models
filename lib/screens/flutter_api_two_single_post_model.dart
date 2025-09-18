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
    return (SinglePostModel.fromJson(responseBody));
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
            // In previous we have been seen that we used ListView.Builder but now in this we dont need of it, after SinglePostModel implementation
            return ListTile(
              // Use ! if you are 100% sure that data will be not null or have respone of API  // This Topic is related Null Safety
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
   // We will see next coming files how these ! (exclamation) ? and question marks
   // will be removed for better code readability and and avoid null safety
   // make better models those have null saftey check 
   // what if API response is not coming due to network or any other reason 
   // so we do it with handling that is designed in models to conditions using ternary operators
   // if name field has something issue like API issue or any mistake are done
   // we handle it like this in way 
   // title.isEmpty ? name : "";
   // or 
   // title = json['title'] ?? "No Title";

   // See Other Files than this file,
   // and other Models than single_post_model.