import 'package:flutter/material.dart';

class ToDoItem {
  String task;
  bool isDone;

  ToDoItem(this.task, this.isDone);
}

class ToDoListWidget extends StatefulWidget {
  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  List<ToDoItem> todoItems = [];
  TextEditingController taskController = TextEditingController();

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        todoItems.add(ToDoItem(task, false));
      });
      taskController.clear();
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
                      _addTask(value);
                    }
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addTask(taskController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todoItems[index].task),
                  leading: Checkbox(
                  value: todoItems[index].isDone,
                  onChanged: (bool? value) {
                    if (value != null) {
                      _toggleTaskState(index);
                    }
                  },
                ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeTask(index);
                    },
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