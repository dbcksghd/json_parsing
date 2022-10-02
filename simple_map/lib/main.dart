import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Student {
  String? name;

  Student({this.name});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
    );
  }
}

Future<Student> getApi() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/typicode/demo/profile'));
  if (response.statusCode == 200) {
    print(response.body);
    return Student.fromJson(json.decode(response.body));
  } else {
    throw Exception('실패');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Student>? student;

  void initState() {
    super.initState();
    student = getApi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('간단한 json 파싱'),
          actions: [
            IconButton(
              onPressed: () {
                getApi();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: student,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.name!);
                  } else if (snapshot.hasError) {
                    return Text('Error');
                  } else
                    return Text('예외');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
