import 'package:guam_community_client/commons/functions_category_boardType.dart';

class Category {
  final int postId;
  final int tagId;
  final String title;

  Category({this.postId, this.tagId, this.title});

  factory Category.fromJson(dynamic json) {
    return Category(
      postId: json['postId'],
      tagId: json['tagId'],
      title: json['title'],
    );
  }
}
