import 'package:flutter/material.dart';
import 'package:fifteen_flutter_apis/screens/flutter_api.dart';
import 'package:fifteen_flutter_apis/screens/flutter_api_one.dart';
import 'package:fifteen_flutter_apis/screens/flutter_api_two_single_post_model.dart';

// These Are Methods of API
// GET    >> Fetch the API
// post   >> means add karna
// GET    >> jab hum koi edit karwana hoga to
// PUT    >> Jab hum update karwana hoga to hum PUT Karenge
// POP    >> Jab hum delte karwana hoga to POP Karenge

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const FlutterApiTwoSinglePostModel(),
    );
  }
}
