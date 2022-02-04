import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Picture {
  final int id;
  final String urlPath;

  Picture({this.id, @required this.urlPath});

  factory Picture.fromJson(dynamic json) {
    return Picture(
      id: json['id'],
      urlPath: json['urlPath'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'urlPath': urlPath};
}
