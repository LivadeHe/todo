import 'package:flutter/material.dart';
import 'package:todo/infrastructure/todo_repository.dart';
import 'package:todo/model/item.dart';


class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ToDoRepository itemRepository = ToDoRepository();
  List<ToDoItem> _availableItems = [];

  @override
  void initState() {
    super.initState();
//    itemRepository.findAll().then((items) {
//      setState(() {
//        _availableItems = items;
//      });
//    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Page'),
      ),
      body: Column(
        children: <Widget>[
          // Your other widgets go here
          Expanded(
            child: ListView.builder(
              itemCount: _availableItems.length,
              itemBuilder: (context, index) {
                final item = _availableItems[index];
                final backgroundColor = item.isDone ? Colors.white : getBackgroundColor(item);
                return Container(
                  color: backgroundColor,
                  child: ListTile(
                    title: Text(_availableItems[index].task),
                    subtitle: Text('Due Date: ${getDueDate(_availableItems[index]) ?? "Not set"}'),
                    leading: Checkbox(
                      value: _availableItems[index].isDone,
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
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditTaskDialog(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
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

  String? getDueDate(ToDoItem item) {
    // Implement your getDueDate logic here
    // You can use your existing getDueDate function or modify it as needed
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

  void _toggleTaskState(int index) {
    setState(() {
      _availableItems[index].isDone = !_availableItems[index].isDone;
    });
  }
}
