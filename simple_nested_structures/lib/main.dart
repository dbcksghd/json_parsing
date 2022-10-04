import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Slide {
  String? name;
  int? currentstatus;

  Slide({this.name, this.currentstatus});

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
      name: json['name'],
      currentstatus: json['currentstatus'],
    );
  }
}

class Profile {
  String? name;

  Profile({this.name});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["name"],
    );
  }
}

class Test {
  Slide? slide;
  Profile? profile;

  Test({this.slide, this.profile});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      slide: json['slide'],
      profile: json['profile'],
    );
  }
}

Future<Test> getApi() async {
  final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/lmodan/myjsonserver/db'));
  print(response.body);
  if (response.statusCode == 200){
    return Test.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('실패');
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
