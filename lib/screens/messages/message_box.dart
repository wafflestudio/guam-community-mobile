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
  int _unReadMsg = 0;
  bool _countRunning = false;

  Future<void> _countMsg() async {
    setState(() => _countRunning = true);
    try {
      await context.read<Messages>().countUnRead();
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _countRunning = false);
  }

  Future<void> _recountMsg() async {
    await context.read<Messages>().countUnRead();
    setState(() => _unReadMsg = context.read<Messages>().unRead);
  }

  @override
  void initState() {
    _countMsg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();
    Messages msgProvider = context.read<Messages>();
    _unReadMsg = context.read<Messages>().unRead;

    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: IconButton(
        icon: SvgPicture.asset(
            _countRunning || _unReadMsg == 0
                ? 'assets/icons/message_default.svg'
                : 'assets/icons/message_new.svg'
        ),
        onPressed: () async {
          await msgProvider.fetchMessageBoxes();
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (_) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => Messages(authProvider)),
              ],
              child: MessageBody(_recountMsg),
            ))
          );
        }
      ),
    );
  }
}
