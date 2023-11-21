// todo_repository.dart
import 'package:flutter/material.dart';
import 'package:todo/presentation/item/todo_item.dart';

class ToDoRepository {
  List<ToDoItem> todoItems = [];

  void addTask(ToDoItem newItem) {
    todoItems.add(newItem);
  }

  void removeTask(int index) {
    todoItems.removeAt(index);
  }

  void toggleTaskState(int index) {
    todoItems[index].isDone = !todoItems[index].isDone;
  }

  Color getBackgroundColor(ToDoItem item) {
    if (item.day == null || item.month == null || item.year == null) {
      return Colors.green;
    }

    final currentDate = DateTime.now();
    final dueDate = DateTime(item.year!, item.month!, item.day!);
    final difference = dueDate.difference(currentDate).inDays;

    if (difference < 0) {
      return Colors.red;
    } else if (difference == 0 || difference == 1) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String? getDueDate(ToDoItem item) {
    if (item.day != null && item.month != null && item.year != null) {
      return '${item.day.toString().padLeft(2, '0')}.${item.month.toString().padLeft(2, '0')}.${item.year.toString()}';
    }
    return null;
  }
}
