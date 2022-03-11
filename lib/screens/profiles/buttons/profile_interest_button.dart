import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/profiles/interest.dart';
import '../../../providers/user_auth/authenticate.dart';

class ProfileInterestButton extends StatefulWidget {
  final Interest interest;
  final bool deletable;
  final void Function(String interest) removeInterest;

  ProfileInterestButton(this.interest, {this.removeInterest, this.deletable = false});

  @override
  State<ProfileInterestButton> createState() => _ProfileInterestButtonState();
}

class _ProfileInterestButtonState extends State<ProfileInterestButton> {
  bool sending = false;

  void toggleSending() {
    setState(() => sending = !sending);
  }

  Future deleteInterest() async {
    toggleSending();

    try {
      return await context.read<Authenticate>().deleteInterest(
        queryParams: {"name": widget.interest.name},
      ).then((successful) {
        if (successful) {
          toggleSending();
          widget.removeInterest(widget.interest.name);
        } else {
          toggleSending();
          print("Error!");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(widget.interest.name),
      labelStyle: TextStyle(
        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        fontSize: 12,
        color: widget.deletable ? GuamColorFamily.grayscaleGray2 : GuamColorFamily.grayscaleGray4,
        height: 19.2/12,
      ),
      onDeleted: widget.deletable ? deleteInterest : null,
      deleteIcon: sending
          ? SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(color: GuamColorFamily.purpleCore),
            )
          : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: GuamColorFamily.grayscaleWhite,
      side: BorderSide(color: GuamColorFamily.grayscaleGray6),
      padding: EdgeInsets.all(4),
    );
  }
}
