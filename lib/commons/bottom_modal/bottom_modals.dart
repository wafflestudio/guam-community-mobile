import 'package:flutter/material.dart';
import 'bottom_modal_functions.dart';

class BottomModalContent extends StatelessWidget {
  final IconData setIcon;
  final String setText;
  final String setDetailText;
  final String editText;
  final String deleteText;
  final String deleteDetailText;
  final Function setFunc;
  final Function editFunc;
  final Function deleteFunc;
  final bool setRequireConfirm;
  final bool deleteRequireConfirm;

  BottomModalContent({
    this.setIcon = Icons.push_pin_outlined,
    this.setText, this.setDetailText, this.editText, this.deleteText, this.deleteDetailText,
    this.setFunc, this.editFunc, this.deleteFunc,
    this.setRequireConfirm = false, this.deleteRequireConfirm = false
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color.fromRGBO(54, 54, 54, 1),
            width: double.infinity,
            child: Column(
              children: [
                if (setFunc != null) BottomModalFunctions(iconData: setIcon, text: setText, detailText: setDetailText, iconColor: Colors.blue, textColor: Colors.blue, customFunction: setFunc, requireConfirm: setRequireConfirm),
                if (editFunc != null) BottomModalFunctions(iconData: Icons.edit_outlined, text: editText, textColor: Colors.white, customFunction: editFunc),
                if (deleteFunc != null) BottomModalFunctions(iconData: Icons.delete_outlined, text: deleteText, detailText: deleteDetailText, iconColor: Colors.red, textColor: Colors.red, customFunction: deleteFunc, requireConfirm: deleteRequireConfirm),
              ],
            ),
          ),
        )
      ],
    );
  }
}
