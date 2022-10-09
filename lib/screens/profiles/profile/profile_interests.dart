import 'package:flutter/material.dart';
import '../buttons/profile_interest_button.dart';
import '../../../models/profiles/interest.dart';

class ProfileInterests extends StatelessWidget {
  final List<Interest>? interests;

  ProfileInterests(this.interests);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 5,
      children: [...interests!.map((i) => ProfileInterestButton(i))],
    );
  }
}
