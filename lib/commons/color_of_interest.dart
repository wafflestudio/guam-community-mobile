import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

colorOfInterest(String interest) {
  HexColor textColor;

  switch (interest) {
    case '개발': textColor = GuamColorFamily.purpleCore; break;
    case '데이터분석': textColor = GuamColorFamily.greenCore; break;
    case '디자인': textColor = GuamColorFamily.pinkCore; break;
    case '기획/마케팅': textColor = GuamColorFamily.blueCore; break;
    default: textColor = GuamColorFamily.orangeCore; break;
  }
  return textColor;
}
