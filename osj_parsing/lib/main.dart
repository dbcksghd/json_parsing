import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  var jsonString = '''
    [
      {
        "id": 1,
        "state": 1,
        "device_type" : "DRY",
        "alive" : 1
      },
      {
        "id": 2,
        "state": 1,
        "device_type" : "DRY",
        "alive" : 1
      },
      {
        "id": 3,
        "state": 1,
        "device_type" : "WASH",
        "alive" : 1
      },
    ]
  ''';

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
