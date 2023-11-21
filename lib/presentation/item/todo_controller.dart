// todo_controller.dart
import 'package:flutter/material.dart';
import 'package:todo/infrastructure/todo_repository.dart';
import 'todo_item.dart';

class ToDoController {
  final ToDoRepository _repository = ToDoRepository();

  List<ToDoItem> get todoItems => _repository.todoItems;

  void addTask(String task, int? day, int? month, int? year) {
    if (task.isNotEmpty) {
      _repository.addTask(ToDoItem(task, false, day: day, month: month, year: year));
    }
  }

  void removeTask(int index) {
    _repository.removeTask(index);
  }

  void toggleTaskState(int index) {
    _repository.toggleTaskState(index);
  }
}
