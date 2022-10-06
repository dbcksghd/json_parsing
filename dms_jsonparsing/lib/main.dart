import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String getSystemTime() {
  var now = DateTime.now();
  return DateFormat("yyy-MM-dd").format(now);
}
class Test {
  Date? date;

  Test({this.date});

  Test.fromJson(Map<String, dynamic> json) {
    date = json['${getSystemTime()}'] != null ? new Date.fromJson(json['${getSystemTime()}']) : null;
    print('${getSystemTime()}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['${getSystemTime()}'] = this.date!.toJson();
    }
    return data;
  }
}

class Date {
  List<String>? breakfast;
  List<String>? dinner;
  List<String>? lunch;

  Date({this.breakfast, this.dinner, this.lunch});

  Date.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'].cast<String>();
    dinner = json['dinner'].cast<String>();
    lunch = json['lunch'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breakfast'] = this.breakfast;
    data['dinner'] = this.dinner;
    data['lunch'] = this.lunch;
    return data;
  }
}

Future<Test> getApi() async {
  final response = await http
      .get(Uri.parse('https://api.dsm-dms.com/meal/${getSystemTime()}'));
  if (response.statusCode == 200) {
    print(json.decode(utf8.decode(response.bodyBytes)));
    return Test.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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
                      return Text(snapshot.data!.date!.breakfast![0].toString());
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
