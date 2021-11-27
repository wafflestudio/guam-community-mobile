import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/home/home_provider.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation.dart';
import 'tab_item.dart';
import 'tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.notification: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime;

    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab = await _navigatorKeys[_currentTab].currentState.maybePop();
          if (isFirstRouteInCurrentTab) {
            // if not on the 'main' tab
            if (_currentTab == TabItem.home) {
              // select 'main' tab
              _selectTab(TabItem.home);
              // back button handled by app
              return false;
            }
          }
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            // 토스트 넣을 때 '뒤로가기를 한번 더 누르면 앱이 종료 됩니다.' 처리하기
            // Fluttertoast.showToast(msg: exit_warning);
            return Future.value(false);
          }
          return Future.value(true);
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(TabItem.home),
            _buildOffstageNavigator(TabItem.search),
            _buildOffstageNavigator(TabItem.notification),
            _buildOffstageNavigator(TabItem.profile),
          ]),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}