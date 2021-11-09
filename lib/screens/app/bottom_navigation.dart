import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/home/home_provider.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return BottomNavigationBar(
      items: homeProvider.bottomNavItems.map((e) =>
        BottomNavigationBarItem(
          label: e['label'],
          icon: currentTab.index == homeProvider.bottomNavItems.indexOf(e)
            ? e['selected_icon']
            : e['unselected_icon'],
        )
      ).toList(),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      currentIndex: currentTab.index,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: GuamColorFamily.purpleCore,
      unselectedItemColor: GuamColorFamily.grayscaleGray4,
      onTap: (index) => onSelectTab(TabItem.values[index]),
    );
  }
}
