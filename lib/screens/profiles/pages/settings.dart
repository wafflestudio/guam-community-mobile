import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/screens/profiles/pages/logout_modal.dart';
import 'package:guam_community_client/screens/profiles/pages/withdrawal_modal.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../buttons/long_button.dart';
import 'blacklist_edit.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        leading: Back(),
        title: '계정 설정',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Wrap(
            runSpacing: 12,
            children: [
              LongButton(
                label: '차단 목록 관리',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlackListEdit()
                  ),
                ),
              ),
              LongButton(
                label: '로그아웃',
                onPressed: () => showMaterialModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (_) => Authenticate()),
                    ],
                    child: LogoutModal(
                      func: () => context.read<Authenticate>().signOut(),
                    ),
                  ),
                ),
              ),
              LongButton(
                label: '계정 삭제',
                onPressed: () => showMaterialModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (_) => Authenticate()),
                    ],
                    child: WithdrawalModal(
                      func: () => context.read<Authenticate>().deleteUser(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
