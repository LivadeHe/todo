import 'package:flutter/material.dart';

class ToDoItem {
  String task;
  bool isDone;
  int? day;
  int? month;
  int? year;

  ToDoItem(this.task, this.isDone, {this.day, this.month, this.year});
}

class ToDoListWidget extends StatefulWidget {
  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  List<ToDoItem> todoItems = [];
  TextEditingController taskController = TextEditingController();
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  void _addTask(String task, int? day, int? month, int? year) {
    if (task.isNotEmpty) {
      setState(() {
        todoItems.add(ToDoItem(task, false, day: day, month: month, year: year));
      });
      taskController.clear();
      resetDropdowns();
    }
  }

  void _removeTask(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  void _toggleTaskState(int index) {
    setState(() {
      todoItems[index].isDone = !todoItems[index].isDone;
    });
  }

  void resetDropdowns() {
    selectedDay = null;
    selectedMonth = null;
    selectedYear = null;
  }

  _showEditTaskDialog(int index) {
  final taskController = TextEditingController();
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  taskController.text = todoItems[index].task;
  dayController.text = todoItems[index].day?.toString() ?? '';
  monthController.text = todoItems[index].month?.toString() ?? '';
  yearController.text = todoItems[index].year?.toString() ?? '';

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
                Expanded(
                  child: TextField(
                    controller: dayController,
                    decoration: InputDecoration(labelText: 'Day'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: monthController,
                    decoration: InputDecoration(labelText: 'Month'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: yearController,
                    decoration: InputDecoration(labelText: 'Year'),
                  ),
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
                todoItems[index].task = taskController.text;
                todoItems[index].day = int.tryParse(dayController.text);
                todoItems[index].month = int.tryParse(monthController.text);
                todoItems[index].year = int.tryParse(yearController.text);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  String? getDueDate(ToDoItem item) {
    if (item.day != null && item.month != null && item.year != null) {
      return '${item.day.toString().padLeft(2, '0')}.${item.month.toString().padLeft(2, '0')}.${item.year.toString()}';
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: Column(
        children: <Widget>[
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
                    }
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
    itemCount: todoItems.length,
    itemBuilder: (context, index) {
      final item = todoItems[index];
      final backgroundColor = getBackgroundColor(item);
      return Container(
        color: backgroundColor,
        child: ListTile(
          title: Text(todoItems[index].task),
          subtitle: Text('Due Date: ${getDueDate(todoItems[index]) ?? "Not set"}'),
          leading: Checkbox(
            value: todoItems[index].isDone,
            onChanged: (bool? value) {
              if (value != null) {
                _toggleTaskState(index);
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
                  _removeTask(index);
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
}
