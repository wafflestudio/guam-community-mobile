import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/profiles/interest.dart';
import '../../../providers/user_auth/authenticate.dart';

class ProfileInterestButton extends StatefulWidget {
  final Interest interest;
  final int index;
  final bool deletable;
  final Function removeInterest;

  ProfileInterestButton(this.interest, {this.index, this.removeInterest, this.deletable = false});

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
      await context.read<Authenticate>().deleteInterest(
        queryParams: {"name": widget.interest.name},
      ).then((successful) {
        toggleSending();
        if (successful) {
          widget.removeInterest(widget.index);
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
    return Chip(
      padding: EdgeInsets.all(4),
      label: Text(widget.interest.name),
      labelStyle: TextStyle(
        fontSize: 12,
        height: 19.2/12,
        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        color: widget.deletable ? GuamColorFamily.grayscaleGray2 : GuamColorFamily.grayscaleGray3,
      ),
      backgroundColor: GuamColorFamily.grayscaleWhite,
      onDeleted: widget.deletable ? deleteInterest : null,
      side: BorderSide(color: GuamColorFamily.grayscaleGray5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
