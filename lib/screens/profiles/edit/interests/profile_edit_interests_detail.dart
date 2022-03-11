import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_interest_button.dart';
import './profile_edit_interests_label.dart';
import './profile_edit_interests_textfield.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../../../commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../../models/profiles/interest.dart';

class ProfileEditInterestsDetail extends StatefulWidget {
  final List<Interest> interests;

  ProfileEditInterestsDetail(this.interests);

  @override
  State<ProfileEditInterestsDetail> createState() => _ProfileEditInterestsDetailState();
}

class _ProfileEditInterestsDetailState extends State<ProfileEditInterestsDetail> {
  List<Interest> _interests;

  @override
  void initState() {
    _interests = widget.interests;
    super.initState();
  }

  void addInterest(String interest) {
    setState(() => _interests.add(Interest(name: interest)));
  }

  void removeInterest(String interest) {
    setState(() => _interests.removeAt(
      _interests.indexWhere((e) => e.name == interest))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        leading: Back(),
        title: '프로필 수정',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileEditInterestsLabel(_interests.length),
              ProfileEditInterestsTextField(addInterest),
              Wrap(
                spacing: 8,
                runSpacing: 5,
                children: [..._interests.map((i) => ProfileInterestButton(
                  i,
                  deletable: true,
                  removeInterest: removeInterest,
                ))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
