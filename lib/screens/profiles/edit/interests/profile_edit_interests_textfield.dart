import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../../../commons/button_size_circular_progress_indicator.dart';
import '../../../../providers/user_auth/authenticate.dart';

class ProfileEditInterestsTextField extends StatefulWidget {
  final void Function(String interest) addInterest;

  ProfileEditInterestsTextField(this.addInterest);

  @override
  State<StatefulWidget> createState() => ProfileEditInterestsTextFieldState();
}

class ProfileEditInterestsTextFieldState extends State<ProfileEditInterestsTextField> {
  bool sending = false;
  final _interestFieldController = TextEditingController();

  void toggleSending() {
    setState(() => sending = !sending);
  }

  Future createInterest() async {
    toggleSending();
    try {
      await context.read<Authenticate>().setInterest(
        body: {"name": _interestFieldController.text},
      ).then((successful) {
        toggleSending();
        if (successful) {
          widget.addInterest(_interestFieldController.text);
          _interestFieldController.clear();
        } else {
          print("Error!");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              controller: _interestFieldController,
              cursorColor: GuamColorFamily.purpleCore,
              style: TextStyle(
                fontSize: 14,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray1,
                height: 22.4/14
              ),
              decoration: InputDecoration(
                hintText: "관심사를 입력해주세요.  ex) SpringBoot",
                hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
            ),
          ),
          !sending ? TextButton(
            onPressed: () => createInterest(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(right: 6),
              minimumSize: Size(30, 26),
              alignment: Alignment.center,
            ),
            child: Text(
              '등록',
              style: TextStyle(
                color: GuamColorFamily.purpleCore,
                fontSize: 14,
              ),
            ),
          ) : ButtonSizeCircularProgressIndicator()
        ],
      ),
      margin: EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: GuamColorFamily.grayscaleGray6, width: 1),
      ),
    );
  }
}
