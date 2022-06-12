import 'dart:convert';

// Translate json response to utf-8 json
String decodeKo(dynamic json) => utf8.decode(json.bodyBytes);
