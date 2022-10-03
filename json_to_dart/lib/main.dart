import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Test>? test;

  @override
  void initState() {
    super.initState();
    test = getApi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Json to dart 사이트 사용법'),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: test,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.name!);
                    } else if (snapshot.hasError) {
                      return Text('에러');
                    } else {
                      return Text('예외');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Test {
  String? name;

  Test({this.name});

  Test.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

Future<Test> getApi() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/typicode/demo/profile'));
  if (response.statusCode == 200) {
    print(response.body);
    return Test.fromJson(json.decode(response.body));
  } else {
    throw Exception('실패');
  }
}