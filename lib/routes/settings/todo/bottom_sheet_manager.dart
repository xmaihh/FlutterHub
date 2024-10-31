// bottom_sheet_manager.dart
import 'package:flutter/material.dart';

import 'custom_bottom_sheet.dart';

class BottomSheetManager {
  static void showCustomBottomSheet({
    required BuildContext context,
    required String hintText,
    required String labelText,
    required TextEditingController controller,
    required VoidCallback onSubmit,
    required IconData icon,
    int maxLines = 4,
    double fontSize = 21,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (builder) => CustomBottomSheet(
        hintText: hintText,
        labelText: labelText,
        controller: controller,
        onSubmit: onSubmit,
        icon: icon,
        maxLines: maxLines,
        fontSize: fontSize,
      ),
    );
  }
}
