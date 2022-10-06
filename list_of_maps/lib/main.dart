import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test {
  int? id;
  String? name;
  String? username;

  Test({this.id, this.name, this.username});

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}

class TestList{
  final List<Test>? tests;
  TestList({this.tests});
  factory TestList.fromJson(List<dynamic> json){
    List<Test> tests = <Test>[];
    tests = json.map((i) => Test.fromJson(i)).toList();

    return TestList(
      tests: tests,
    );
  }
}

Future<TestList> getApi() async {
  final response = await http.get(Uri.parse('https://my-json-server.typicode.com/Ygdrassil/cc/users'));
  print(response.body);
  if (response.statusCode == 200){
    return TestList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('예외처리');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<TestList>? test;
  @override
  void initState(){
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
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return Text(snapshot.data!.tests![0].name.toString());
                    } else if (snapshot.hasError){
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
