import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/boards/boards_app.dart';
import 'package:guam_community_client/screens/app/tab_item.dart';
import 'package:guam_community_client/screens/notifications/notifications_app.dart';
import 'package:guam_community_client/screens/profiles/profiles_app.dart';
import 'package:guam_community_client/screens/search/search_app.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {

  TabNavigator({@required this.navigatorKey, @required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    switch(tabItem){
      case TabItem.home: return {TabNavigatorRoutes.root: (context) => BoardsApp()};
      case TabItem.search: return {TabNavigatorRoutes.root: (context) => SearchApp()};
      case TabItem.notification: return {TabNavigatorRoutes.root: (context) => NotificationsApp()};
      case TabItem.profile: return {TabNavigatorRoutes.root: (context) => ProfilesApp()};
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
