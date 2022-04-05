class Category {
  final int postId;
  final int categoryId;
  final String title;

  Category({this.postId, this.categoryId, this.title});

  factory Category.fromJson(dynamic json) {
    return Category(
      postId: json['postId'],
      categoryId: json['categoryId'],
      title: json['title'],
    );
  }
}
