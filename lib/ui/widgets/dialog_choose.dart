import 'package:flutter/material.dart';

class DialogChoose extends StatelessWidget {
  String title;
  String message;
  BuildContext context;
  Function onClickYes;
  Function onClickNo;

  DialogChoose({
    this.title,
    this.message,
    this.context,
    this.onClickYes,
    this.onClickNo
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      content: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        )
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => onClickYes(),
          child: Text(
            "YA",
          ),
        ),
        FlatButton(
          onPressed: () => onClickNo(),
          child: Text(
            "TIDAK",
          ),
        ),
      ],
    );
  }
}