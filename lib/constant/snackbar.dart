import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({
    required this.message,
  });

  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(message),
        duration: const Duration(seconds: 3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
      ),
    );
  }
}
