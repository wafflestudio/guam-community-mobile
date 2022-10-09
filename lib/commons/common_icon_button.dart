import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color? iconColor;

  CommonIconButton({required this.icon, required this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: iconColor),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
          maxWidth: 24, maxHeight: 24
      ),
      onPressed: onPressed as void Function()?
    );
  }
}
