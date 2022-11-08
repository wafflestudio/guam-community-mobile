import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/screens/recruit/search/project_search.dart';
import 'package:provider/provider.dart';

import '../../../providers/recruit/recruit.dart';
import '../../../providers/user_auth/authenticate.dart';

class SearchButton extends StatelessWidget {

  SearchButton();

  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();

    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: IconButton(
          icon: SvgPicture.asset(
              'assets/icons/search.svg'
          ),
          onPressed: () {
            // 검색창으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (_) => Recruit(authProvider)),
                    ],
                    child: ProjectSearch()),
              ),
            );
          }
      ),
    );
  }


}