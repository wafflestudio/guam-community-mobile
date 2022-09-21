import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/providers/home/home_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/share/share.dart';
import 'bottom_navigation.dart';
import 'tab_item.dart';
import 'tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> with Toast {
  var _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.project: GlobalKey<NavigatorState>(),
    TabItem.notification: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // 현재 탭 버튼 두 번 누르면 해당 탭의 처음 루트로 복귀
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        // 알림 탭 FutureBuilder가 탭 전환 시 null을 받게 되는 현상 회피
        if (_currentTab == TabItem.notification)
          _navigatorKeys[_currentTab]!.currentState!.popUntil((route) => route.isFirst);
        _currentTab = tabItem;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    Share(context: context).addListener((){
      setState(() {
        _currentTab = TabItem.home;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab = await _navigatorKeys[_currentTab]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            // if not on the 'main' tab
            if (_currentTab == TabItem.home) {
              // select 'main' tab
              _selectTab(TabItem.home);
              // back button handled by app
              return false;
            }
          }
          return Future.value(true);
          // let system handle back button if we're on the first route
          // return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(TabItem.home),
            _buildOffstageNavigator(TabItem.search),
            _buildOffstageNavigator(TabItem.project),
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
