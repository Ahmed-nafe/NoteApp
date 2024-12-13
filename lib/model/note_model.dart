import 'package:flutter/material.dart';

class NoteModel {
  String id;
  String title;
  String description;
  String color;

  NoteModel({
    required this.id,
    required this.color,
    required this.title,
    required this.description,
  });

  NoteModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          description: json["description"],
          color: json["color"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "color": color,
    };
  }

  Color getColor() {
    try {
      String hexColor = color.replaceAll("#", "");
      return Color(int.parse("0xff$hexColor"));
    } catch (e) {
      return Colors.white;
    }
  }
}
