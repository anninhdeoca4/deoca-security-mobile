// custom_flushbar.dart
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class CustomFlushbar {
  static Future<void> show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    IconData? icon,
    bool autoPopHome = false, // mới
    Duration duration = const Duration(seconds: 3),
  }) async {
    if (!context.mounted) return;
    await Flushbar(
      message: message,
      backgroundColor: backgroundColor,
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(icon ?? Icons.info, color: Colors.white),
    ).show(context);

    if (autoPopHome && context.mounted) {
      // quay về màn hình Home
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }
}
