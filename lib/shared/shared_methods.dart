import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';

void showCustomSnackBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: primaryColor,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(10),
    duration: const Duration(seconds: 2),
  ).show(context);
}
