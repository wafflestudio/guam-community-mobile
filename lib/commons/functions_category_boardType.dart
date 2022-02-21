import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

// dummy data의 boardType이 enum으로 잘 담겨져 오면 지울 함수
transferBoardType(int boardId) {
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

// dummy data의 Category가 enum으로 잘 담겨져 오면 지울 함수
transferCategory(String engCategory) {
  String korCategory;

  switch (engCategory) {
    case 'Data Science': korCategory = '데이터분석'; break;
    case 'Programming': korCategory = '개발'; break;
    default: korCategory = engCategory; break;
  }
  return korCategory;
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
