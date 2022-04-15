import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

// dummy data의 boardType이 enum으로 잘 담겨져 오면 지울 함수
transferBoardId(int boardId) {
  String boardType;
  switch (boardId) {
    case 1: boardType = '익명'; break;
    case 2: boardType = '자유'; break;
    case 3: boardType = '구인'; break;
    case 4: boardType = '정보공유'; break;
    case 5: boardType = '홍보'; break;
    default: boardType = '자유'; break;
  }
  return boardType;
}

transferBoardType(String boardType) {
  int boardId;
  switch (boardType) {
    case '익명': boardId = 1; break;
    case '자유': boardId = 2; break;
    case '구인': boardId = 3; break;
    case '정보공유': boardId = 4; break;
    case '홍보': boardId = 5; break;
  }
  return boardId;
}

transferCategoryId(int categoryId) {
  String category;
  switch (categoryId) {
    case 1: category = '개발'; break;
    case 2: category = '데이터분석'; break;
    case 3: category = '디자인'; break;
    case 4: category = '기획/마케팅'; break;
    case 5: category = '기타'; break;
  }
  return category;
}

transferCategory(String category) {
  int categoryId;
  switch (category) {
    case '개발': categoryId = 1; break;
    case '데이터분석': categoryId = 2; break;
    case '디자인': categoryId = 3; break;
    case '기획/마케팅': categoryId = 4; break;
    case '기타': categoryId = 5; break;
  }
  return categoryId;
}

colorOfCategory(String category) {
  HexColor textColor;

  switch (category) {
    case '개발': textColor = GuamColorFamily.purpleCore; break;
    case '데이터분석': textColor = GuamColorFamily.greenCore; break;
    case '디자인': textColor = GuamColorFamily.pinkCore; break;
    case '기획/마케팅': textColor = GuamColorFamily.blueCore; break;
    case '기타': textColor = GuamColorFamily.orangeCore; break;
    default: textColor = GuamColorFamily.grayscaleGray2; break;
  }
  return textColor;
}
