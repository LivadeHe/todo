import 'package:flutter/material.dart';
import 'package:todo/presentation/item/todo_list_widget.dart';
import 'package:todo/infrastructure/todo_repository.dart';
import 'package:todo/presentation/item/todo_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ToDoController _controller = ToDoController();
  final ToDoRepository _repository = ToDoRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      home: ToDoListWidget(repository: _repository, controller: _controller),
    );
  }
}