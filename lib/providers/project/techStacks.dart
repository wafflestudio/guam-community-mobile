import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';
import '../../mixins/toast.dart';

class TechStacks extends ChangeNotifier with Toast {
  // _stacks init to empty list for avoiding errors from calling get stacks,
  // when fetchStacks() has not yet ended.
  List<TechStack> _techStacks = [
    TechStack(
      id: 0,
      name: '상관없음',
      aliases: [],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'SERVER',
    ),
    TechStack(
      id: 1,
      name: '상관없음',
      aliases: [],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'WEB',
    ),
    TechStack(
      id: 2,
      name: '상관없음',
      aliases: [],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'MOBILE',
    ),
    TechStack(
      id: 3,
      name: '상관없음',
      aliases: [],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'DESIGNER',
    ),
    TechStack(
      id: 4,
      name: 'Flutter',
      aliases: ['Flutter', 'CrossPlatform'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'MOBILE',
    ),
    TechStack(
      id: 5,
      name: 'React',
      aliases: ['React'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'WEB',
    ),
    TechStack(
      id: 6,
      name: 'Spring',
      aliases: ['SpringBoot', 'Spring', 'kotlin', 'java'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'SERVER',
    ),
    TechStack(
      id: 7,
      name: 'Figma',
      aliases: ['Figma', 'Figma'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'DESIGNER',
    ),
    TechStack(
      id: 8,
      name: 'AdobeXD',
      aliases: ['Adobe', 'XD', 'AdobeXD'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'DESIGNER',
    ),
    TechStack(
      id: 9,
      name: 'Django',
      aliases: ['Django', 'Dj', 'python'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'SERVER',
    ),
    TechStack(
      id: 10,
      name: 'Vue',
      aliases: ['Vue', 'Vue.js', 'Vue.ts'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'WEB',
    ),
    TechStack(
      id: 11,
      name: 'ReactNative',
      aliases: ['ReactNative', 'RN'],
      icon: 'https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI=w480-h960',
      position: 'MOBILE',
    ),
  // final int? id;
  // final String? name;
  // List<String>? aliases;
  // String? icon;
  // String? position;
  ];

  TechStacks() {
    // fetchStacks();
  }

  get techStacks => _techStacks;

  Future<void> fetchStacks() async {
    try {
      await HttpRequest().get(
          // path: "/_techStacks"
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8);
          _techStacks = jsonList.map((e) => TechStack.fromJson(e)).toList();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
