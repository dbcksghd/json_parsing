import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test {
  Slide? slide;
  Profile? profile;

  Test({this.slide, this.profile});

  Test.fromJson(Map<String, dynamic> json) {
    slide = json['slide'] != null ? new Slide.fromJson(json['slide']) : null;
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slide != null) {
      data['slide'] = this.slide!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Slide {
  String? name;
  int? currentstatus;

  Slide({this.name, this.currentstatus});

  Slide.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currentstatus = json['currentstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['currentstatus'] = this.currentstatus;
    return data;
  }
}

class Profile {
  String? name;

  Profile({this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

Future<Test> getApi() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/lmodan/myjsonserver/db'));
  print(response.body);
  if (response.statusCode == 200){
    return Test.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('예외처리');
  }
}

void main() =>runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Test>? test;

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
                      return Text(snapshot.data!.slide!.name!);
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
