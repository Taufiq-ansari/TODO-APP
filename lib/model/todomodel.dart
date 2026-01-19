import 'dart:ui';
import 'package:flutter/material.dart';

class TodoModel {
  final int? id;
  String? title;
  String? description;
  int priority;



  TodoModel({ this.id,
    required this.title,
    required this.description,
     this.priority =1,

  });



  // from json
  factory TodoModel.fromJson(Map<String, String> json) {
    return TodoModel(
      id : json["id"] as  int,
      title: json["title"],
      description: json["description"],
    );
  }

  // tomap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}
