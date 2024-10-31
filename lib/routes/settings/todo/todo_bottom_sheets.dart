// todo_bottom_sheets.dart
import 'package:flutter/material.dart';
import 'package:flutter_hub/models/index.dart';

import 'bottom_sheet_manager.dart';

class TodoBottomSheets {
  static void showAddOrEditTodoSheet(
    BuildContext context,
    Todo? todo,
    Function(String) onAdd,
    Function(int, String) onEdit,
    VoidCallback onComplete,
  ) {
    final controller = TextEditingController(text: todo?.title ?? '');

    BottomSheetManager.showCustomBottomSheet(
      context: context,
      hintText: 'I have to...',
      labelText: todo == null ? 'New Todo' : 'Edit Todo',
      controller: controller,
      icon: Icons.save,
      onSubmit: () {
        final newTodo = controller.text;
        if (newTodo.isNotEmpty) {
          if (todo == null) {
            onAdd(newTodo);
          } else {
            onEdit(todo.id, newTodo);
          }
          Navigator.pop(context);
          onComplete();
        }
      },
    );
  }

  static void showTodoSearchSheet(
    BuildContext context,
    Function(String) onSearch,
  ) {
    final controller = TextEditingController();

    BottomSheetManager.showCustomBottomSheet(
      context: context,
      hintText: 'Search for todo...',
      labelText: 'Search *',
      controller: controller,
      icon: Icons.search,
      fontSize: 18,
      onSubmit: () {
        onSearch(controller.text);
        Navigator.pop(context);
      },
    );
  }
}
