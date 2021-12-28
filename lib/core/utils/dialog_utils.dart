import 'package:flutter/material.dart';
import 'package:tubles/ui/widgets/dialog_choose.dart';

class DialogUtils {

  static void showDialogChoose(BuildContext context, String title, String message, Function? clickYes, Function? clickNo) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: DialogChoose(
              title: title,
              message: message,
              onClickNo: () => clickNo!(),
              onClickYes: () => clickYes!(),
            )
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
  }
}