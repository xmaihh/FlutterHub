// empty_state.dart

import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? subMessage;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final double? height;
  final TextStyle? messageStyle;
  final TextStyle? subMessageStyle;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.subMessage,
    this.icon = Icons.inbox_outlined,
    this.iconSize = 64,
    this.iconColor,
    this.height,
    this.messageStyle,
    this.subMessageStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: messageStyle ??
                  TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                style: subMessageStyle ??
                    TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
