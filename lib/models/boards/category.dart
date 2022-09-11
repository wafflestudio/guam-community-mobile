/// category.title 은 게시글 수정 시 non-final 로 정의
class Category {
  final int? postId;
  final int? categoryId;
  String? title;

  Category({this.postId, this.categoryId, this.title});

  factory Category.fromJson(dynamic json) {
    return Category(
      postId: json['postId'],
      categoryId: json['categoryId'],
      title: json['title'],
    );
  }
}
