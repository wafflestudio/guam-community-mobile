import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../providers/user_auth/authenticate.dart';
import 'message_body.dart';

class MessageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Messages(authProvider)),
      ],
      child: MessageBoxScaffold(),
    );
  }
}

class MessageBoxScaffold extends StatefulWidget {
  @override
  State<MessageBoxScaffold> createState() => _MessageBoxScaffoldState();
}

class _MessageBoxScaffoldState extends State<MessageBoxScaffold> {
  final bool newMessage = true;

  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();
    final msgProvider = context.read<Messages>();

    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: IconButton(
        icon: SvgPicture.asset(
          newMessage
            ? 'assets/icons/message_new.svg'
            : 'assets/icons/message_default.svg'
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (_) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => Messages(authProvider)),
              ],
              child: MessageBody(msgProvider.messageBoxes),
            ))
          );
        }
      ),
    );
  }
}
