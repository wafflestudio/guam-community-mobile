enum CategoryType { dev, data, design, marketing, etc }

const Map<CategoryType, String> categoryType = {
  CategoryType.dev: '개발',
  CategoryType.data: '데이터분석',
  CategoryType.design: '디자인',
  CategoryType.marketing: '기획/마케팅',
  CategoryType.etc: '기타',
};

List<Map<String, dynamic>> categoryList = [
  {'id': 1, 'name': CategoryType.dev},
  {'id': 2, 'name': CategoryType.data},
  {'id': 3, 'name': CategoryType.design},
  {'id': 4, 'name': CategoryType.marketing},
  {'id': 5, 'name': CategoryType.etc},
];
