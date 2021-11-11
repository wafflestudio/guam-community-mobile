import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';

class HomeProvider with ChangeNotifier {
  int _idx = 0;

  final List<Map<String, dynamic>> bottomNavItems = [
    {
      'label': '홈',
      'selected_icon': SvgPicture.asset(
        'assets/icons/home_filled.svg',
        color: GuamColorFamily.purpleCore,
      ),
      'unselected_icon': SvgPicture.asset(
        'assets/icons/home_outlined.svg',
        color: GuamColorFamily.grayscaleGray4,
      ),
    },
    {
      'label': '검색',
      'selected_icon': SvgPicture.asset(
        'assets/icons/search.svg',
        color: GuamColorFamily.purpleCore,
      ),
      'unselected_icon': SvgPicture.asset(
        'assets/icons/search.svg',
        color: GuamColorFamily.grayscaleGray4,
      ),
    },
    {
      'label': '알림',
      'selected_icon': SvgPicture.asset(
        'assets/icons/notification_filled_default.svg',
        color: GuamColorFamily.purpleCore,
      ),
      'unselected_icon': SvgPicture.asset(
        'assets/icons/notification_outlined_default.svg',
        color: GuamColorFamily.grayscaleGray4,
      ),
    },
    {
      'label': '프로필',
      'selected_icon': SvgPicture.asset(
        'assets/icons/profile_filled.svg',
        color: GuamColorFamily.purpleCore,
      ),
      'unselected_icon': SvgPicture.asset(
        'assets/icons/profile_outlined.svg',
        color: GuamColorFamily.grayscaleGray4,
      ),
    },
  ];

  get idx => _idx;

  set idx(val) {
    _idx = val;
    notifyListeners();
  }

  Map<String, dynamic> get bottomNavItem => bottomNavItems[_idx];
}
