import 'package:flutter/material.dart';

class TechStack extends ChangeNotifier {
  final int? id;
  final int? name;
  List<String>? aliases;
  String? icon;
  String? position;


  TechStack({
    this.id,
    this.name,
    this.aliases,
    this.icon,
    this.position,
  });


  factory TechStack.fromJson(Map<String, dynamic> json) {
    return TechStack(
      id: json['id'],
      name: json['name'],
      aliases: json['aliases'],
      icon: json['icon'],
      position: json['position'],
    );
  }
}