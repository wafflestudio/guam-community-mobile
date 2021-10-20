import 'package:flutter/material.dart';
import '../../screens/homes/homes_app.dart';
import '../../screens/search/search_app.dart';
import '../../screens/notifications/notifications_app.dart';
import '../../screens/profiles/profiles_app.dart';

class HomeProvider with ChangeNotifier {
  int _idx = 0;

  final List<Widget> bodyItems = [
    HomesApp(),
    SearchApp(),
    NotificationsApp(),
    ProfilesApp()
  ];

  final List<Map<String, dynamic>> bottomNavItems = [
    {
      'label': '홈',
      'icon': Icons.house_sharp,
    },
    {
      'label': '검색',
      'icon': Icons.search,
    },
    {
      'label': '알림',
      'icon': Icons.notifications,
    },
    {
      'label': '프로필',
      'icon': Icons.person,
    },
  ];

  get idx => _idx;

  set idx(val) {
    _idx = val;
    notifyListeners();
  }

  Widget get bodyItem => bodyItems[_idx];
  Map<String, dynamic> get bottomNavItem => bottomNavItems[_idx];
}
