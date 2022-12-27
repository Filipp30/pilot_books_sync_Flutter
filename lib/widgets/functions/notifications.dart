import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showExceptionDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String actionText
}) async {
  if (Platform.isIOS) {
    return await showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(actionText),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        )
    );
  }
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(actionText),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      )
  );
}

Future<void> showSnackBar({
  required BuildContext context,
  required String message,
  required Color color
}) async {
  final snackBar = SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 4),
    content: Text(message, style: const TextStyle(fontSize: 15.0),),
    action: SnackBarAction(label: 'Close', onPressed: (){}),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
