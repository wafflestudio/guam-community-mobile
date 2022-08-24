import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../commons/bottom_modal/bottom_modal_with_alert.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/custom_divider.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../../styles/fonts.dart';
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
                    )
                  )
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
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '정말 로그아웃 하시겠어요?',
                                    style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                                  ),
                                  TextButton(
                                    child: Text(
                                      '돌아가기',
                                      style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(30, 26),
                                      alignment: Alignment.centerRight,
                                    ),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                              CustomDivider(color: GuamColorFamily.grayscaleGray7),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  '다시 로그인할 사람 괌!',
                                  style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular),
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () async {
                                    context.read<Authenticate>().signOut();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '로그아웃',
                                    style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
