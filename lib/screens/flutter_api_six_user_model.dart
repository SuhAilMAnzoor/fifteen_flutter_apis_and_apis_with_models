import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fifteen_flutter_apis/models/best_user_model.dart';
import 'package:http/http.dart' as http;

class FlutterApiSixUserModel extends StatefulWidget {
  const FlutterApiSixUserModel({super.key});

  @override
  State<FlutterApiSixUserModel> createState() => _FlutterApiSixUserModelState();
}

class _FlutterApiSixUserModelState extends State<FlutterApiSixUserModel> {
  Future<List<UserModel>> getUsers() async {
    List<UserModel> allUsers = [];
    var url = Uri.https('jsonplaceholder.typicode.com', '/users');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    for (var i in responseBody) {
      allUsers.add(UserModel.fromJson(i));
    }
    return allUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<UserModel>>(
          future: getUsers(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error ${snapshot.error}"));
            }

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  var allUsers = snapshot.data![index];
                  return Card(
                    shadowColor: Colors.grey,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          "${snapshot.data![index].id}",
                        ), //for Learning Purpose
                      ),
                      title: Text(
                        allUsers.name.isEmpty
                            ? "No Name"
                            : "Name: ${allUsers.name}",
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username: ${allUsers.username}"),
                          Text("Email: ${allUsers.email}"),
                          Text("Phone: ${allUsers.phone}"),
                          Text(
                            "Address: ${allUsers.address.street} City ${allUsers.address.city}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: Text("No Data Avilable"));
          },
        ),
      ),
    );
  }
}
