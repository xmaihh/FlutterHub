import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {Duration duration = const Duration(seconds: 3), String? actionLabel, VoidCallback? onAction}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      duration: duration,
      action: actionLabel != null && onAction != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction,
            )
          : null,
    ),
  );
}
