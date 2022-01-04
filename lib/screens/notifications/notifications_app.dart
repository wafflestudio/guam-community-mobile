import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/providers/notifications/notifications.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import 'notifications_body.dart';
import '../../commons/custom_app_bar.dart';

class NotificationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Notifications(
          authToken: context.read<Authenticate>().authToken),
        ),
      ],
      child: NotificationsAppScaffold(),
    );
  }
}


class NotificationsAppScaffold extends StatefulWidget {
  @override
  State<NotificationsAppScaffold> createState() => _NotificationsAppScaffoldState();
}

class _NotificationsAppScaffoldState extends State<NotificationsAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        title: '알림',
        trailing: Padding(
          padding: EdgeInsets.only(right: 11),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset('assets/icons/delete_outlined.svg'),
            onPressed: () {},
            ),
          )
        ),
      body: NotificationsBody(),
    );
  }
}
