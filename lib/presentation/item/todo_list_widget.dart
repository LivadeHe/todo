import 'package:flutter/material.dart';
import 'todo_controller.dart';
import 'package:todo/infrastructure/todo_repository.dart';

class ToDoListWidget extends StatefulWidget {
  final ToDoRepository repository;
  final ToDoController controller;

  ToDoListWidget({required this.repository, required this.controller});

  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  final ToDoController _controller = ToDoController();
  TextEditingController taskController = TextEditingController();
  final ToDoRepository _repository = ToDoRepository();
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(labelText: 'New Task'),
                    onSubmitted: (value) {
                      _addTask(value, selectedDay, selectedMonth, selectedYear);
                    },
                  ),
                ),
                DropdownButton<int>(
                  value: selectedDay,
                  hint: Text('Day'),
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                  items: List.generate(31, (index) => (index + 1))
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  value: selectedMonth,
                  hint: Text('Month'),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                  items: List.generate(12, (index) => (index + 1))
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  value: selectedYear,
                  hint: Text('Year'),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                  items: List.generate(10, (index) => (2023 + index))
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addTask(taskController.text, selectedDay, selectedMonth, selectedYear);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _controller.todoItems.length,
              itemBuilder: (context, index) {
                final item = _controller.todoItems[index];
                final backgroundColor = item.isDone ? Colors.white : _repository.getBackgroundColor(item);
                return Container(
                  color: backgroundColor,
                  child: ListTile(
                    title: Text(_controller.todoItems[index].task),
                    subtitle: Text('Due Date: ${_repository.getDueDate(_controller.todoItems[index]) ?? "Not set"}'),
                    leading: Checkbox(
                      value: _controller.todoItems[index].isDone,
                      onChanged: (bool? value) {
                        if (value != null) {
                          _controller.toggleTaskState(index);
                        }
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditTaskDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _repository.removeTask(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(String task, int? day, int? month, int? year) {
    _controller.addTask(task, day, month, year);

    setState(() {
      taskController.text = '';
      selectedDay = null;
      selectedMonth = null;
      selectedYear = null;
    });
  }

  _showEditTaskDialog(int index) {
  final taskController = TextEditingController();
  taskController.text = _controller.todoItems[index].task;

  int? selectedDay = _controller.todoItems[index].day;
  int? selectedMonth = _controller.todoItems[index].month;
  int? selectedYear = _controller.todoItems[index].year;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task'),
            ),
            Row(
              children: <Widget>[
                DropdownButton<int>(
                  value: selectedDay,
                  hint: Text('Day'),
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                  items: List.generate(31, (index) => (index + 1))
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  value: selectedMonth,
                  hint: Text('Month'),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                  items: List.generate(12, (index) => (index + 1))
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  value: selectedYear,
                  hint: Text('Year'),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                  items: List.generate(10, (index) => (2023 + index))
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              setState(() {
                _controller.todoItems[index].task = taskController.text;
                _controller.todoItems[index].day = selectedDay;
                _controller.todoItems[index].month = selectedMonth;
                _controller.todoItems[index].year = selectedYear;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}
