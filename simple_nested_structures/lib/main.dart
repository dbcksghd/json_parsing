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

