import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test {
  List<Users>? users;

  Test({this.users});

  Test.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String? password;
  int? age;

  Users(
      {this.id, this.name, this.lastName, this.email, this.password, this.age});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['age'] = this.age;
    return data;
  }
}

Future<Test> getApi() async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/jlgalarza3/1.2-pet-project/db'));
  print(response.body);
  if (response.statusCode == 200){
    return Test.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('예외 처리');
  }
}

void main() => runApp(MyApp());

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
                       return Text(snapshot.data!.users![0].email.toString());
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
