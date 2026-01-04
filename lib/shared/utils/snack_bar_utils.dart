import 'package:flutter/material.dart';

class SnackBarUtils {
  const SnackBarUtils._internal();

  static void show({
    required BuildContext context,
    required String message,
    String label = '네',
    VoidCallback? onPressed,
  }) {
    final action = onPressed == null
        ? null
        : SnackBarAction(
            label: label,
            onPressed: onPressed,
          );

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        action: action,
      ),
    );
  }
}
