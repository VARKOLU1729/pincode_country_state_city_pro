import 'package:flutter/material.dart';

void showErrorSnackBar(
    {required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          content,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      duration: const Duration(seconds: 2),
      elevation: 6,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
    ),
  );
}
