import 'package:flutter/material.dart';
class ToDoItem {
  String task;
  bool isDone;
  int? day;
  int? month;
  int? year;

  ToDoItem(this.task, this.isDone, {this.day, this.month, this.year});
}
