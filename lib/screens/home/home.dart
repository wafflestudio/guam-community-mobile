import 'package:flutter/material.dart';
import 'package:guam_community_client/main.dart';
import 'package:provider/provider.dart';
import '../../providers/home/home_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      body: homeProvider.bodyItem,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MyApp.themeColor,
        type: BottomNavigationBarType.fixed,
        onTap: (idx) => homeProvider.idx = idx,
        currentIndex: homeProvider.idx,
        items: homeProvider.bottomNavItems.map((e) =>
          BottomNavigationBarItem(
            label: e['label'],
            icon: Icon(e['icon']),
          )
        ).toList(),
      ),
    );
  }
}
