import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/providers/project/techStacks.dart';
import 'package:provider/provider.dart';

import '../../../providers/recruit/recruit.dart';
import '../../../styles/colors.dart';
import '../creation/project_creation.dart';

class CreateProjectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: context.read<Recruit>(),
                child: ProjectCreate(techStacksProvider: context.read<TechStacks>()),
              ),
            ),
          ),
          backgroundColor: GuamColorFamily.purpleCore,
          child: SvgPicture.asset(
            'assets/icons/plus.svg',
            color: GuamColorFamily.grayscaleWhite,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}