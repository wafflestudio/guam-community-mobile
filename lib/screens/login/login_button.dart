import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginButton extends StatelessWidget {
  final String logo;
  final String platform;
  final HexColor bgColor;
  final HexColor textColor;
  final Function onTap;

  LoginButton(this.logo, this.platform, this.bgColor, this.textColor, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: GuamColorFamily.grayscaleGray6, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: null,
                padding: EdgeInsets.only(right: 8),
                constraints: BoxConstraints(),
                icon: SvgPicture.asset(
                  'assets/logos/$logo.svg',
                  /// 애플로그인 전용 (글자 및 로고색이 흰색)
                  color: textColor != GuamColorFamily.grayscaleWhite
                      ? null : GuamColorFamily.grayscaleWhite,
                ),
              ),
              Text(
                platform,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
