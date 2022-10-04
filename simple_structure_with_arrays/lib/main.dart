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
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: test,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: 300.0,
                        height: 300.0,
                        child: ListView(
                          children: [
                            Text(snapshot.data!.names![0]),
                            Text(snapshot.data!.names![1]),
                            Text(snapshot.data!.names![2]),
                            Text(snapshot.data!.names![3]),
                            Text(snapshot.data!.names![4]),
                            Text(snapshot.data!.names![5]),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('에러');
                    } else {
                      return Text('실패');
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
  List<String>? names;

  Test({this.names});

  Test.fromJson(Map<String, dynamic> json) {
    names = json['names'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['names'] = this.names;
    return data;
  }
}

Future<Test> getApi() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/jon-sparks/jsontest/db'));
  print(response.body);

  ///가공 안된 json 데이터
  final jsonResponse = json.decode(response.body);
  Test test = Test.fromJson(jsonResponse);

  ///가공된 json 데이터
  print(test.names);
  if (response.statusCode == 200) {
    return Test.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('실패');
  }
}
