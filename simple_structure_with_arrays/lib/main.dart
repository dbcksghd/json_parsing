import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Test {
  List<Posts>? posts;

  Test({this.posts});

  Test.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? id;
  String? title;
  String? location;
  String? image;
  String? description;
  String? schedule;
  double? rating;

  Posts(
      {this.id,
        this.title,
        this.location,
        this.image,
        this.description,
        this.schedule,
        this.rating});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    image = json['image'];
    description = json['description'];
    schedule = json['schedule'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['location'] = this.location;
    data['image'] = this.image;
    data['description'] = this.description;
    data['schedule'] = this.schedule;
    data['rating'] = this.rating;
    return data;
  }
}