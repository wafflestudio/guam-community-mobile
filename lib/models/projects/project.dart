import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';

import '../profiles/profile.dart';

class Project extends ChangeNotifier {
  final int? id;
  final Profile? leader;
  final bool? isMine;
  final String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? due;
  String? thumbnail;
  List<TechStack>? techStacks;
  int? totalHeadCount;
  int? totalHeadLeft;
  int? serverHeadCount;
  int? serverHeadLeft;
  int? webHeadCount;
  int? webHeadLeft;
  int? mobileHeadCount;
  int? mobileHeadLeft;
  int? designerHeadCount;
  int? designerHeadLeft;
  int? starCount;
  String? status; // ENUM : recruiting, developing, paused, done
  bool? starred;

  Project({
    this.id,
    this.leader,
    this.isMine,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.due,
    this.thumbnail,
    this.techStacks,
    this.totalHeadCount,
    this.totalHeadLeft,
    this.serverHeadCount,
    this.serverHeadLeft,
    this.webHeadCount,
    this.webHeadLeft,
    this.mobileHeadCount,
    this.mobileHeadLeft,
    this.designerHeadCount,
    this.designerHeadLeft,
    this.starCount,
    this.status,
    this.starred,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'star': this.starCount,
      'createdAt': this.createdAt,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    Profile? profile;
    List<TechStack>? techStacks;

    if (json['leader'] != null) {
      profile = Profile.fromJson(json['leader']);
    }

    if (json['techStacks'] != null) {
      techStacks = [...json['techStacks'].map((comment) => TechStack.fromJson({
        'id': comment['id'],
        'name': comment['name'],
        'aliases': comment['aliases'],
        'icon': json['icon'],
        'position': comment['position'],
      }))];
    }

    return Project(
      id: json['id'],
      leader: profile,
      isMine: json['isMine'],
      createdAt: json['createdAt'],
      title: json['title'],
      description: json['description'],
      due: json['due'],
      thumbnail: json['thumbnail'],
      techStacks: techStacks,
      totalHeadCount: json['totalHeadCount'],
      totalHeadLeft: json['totalHeadLeft'],
      serverHeadCount: json['serverHeadCount'],
      serverHeadLeft: json['serverHeadLeft'],
      webHeadCount: json['webHeadCount'],
      webHeadLeft: json['webHeadLeft'],
      mobileHeadCount: json['mobileHeadCount'],
      mobileHeadLeft: json['mobileHeadLeft'],
      designerHeadCount: json['DesignerHeadCount'],
      designerHeadLeft: json['DesignerHeadLeft'],
      starCount: json['starCount'],
      status: json['status'],
      updatedAt: json['updatedAt'],
      starred: json['starred'],
    );
  }
}