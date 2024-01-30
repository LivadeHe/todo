import 'package:flutter/material.dart';
<<<<<<< HEAD
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



=======
import 'package:get/get.dart';
import 'package:todo/presentation/item/item_controller.dart';
import '../../infrastructure/item.dart';

// Hinzufügen neuer Element


class ItemPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
>>>>>>> cc73b2e6c69e71cae38028fb61ad12fa3b2dda01

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
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
=======
        title: Text('Add ToDo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Item Title'),

            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _selectedDate = await _selectDate(context, _selectedDate);

                if (_controller.text.isNotEmpty) {
                  Get.find<ItemController>().addItem(Item(
                    id: DateTime.now().toString(),
                    title: _controller.text,
                    isDone: false,
                    day: _selectedDate?.day,
                    month: _selectedDate?.month,
                    year: _selectedDate?.year,
                  ));
                  Get.back();
                }
              },

              child: Text('Add ToDo'),
            ),
          ],
        ),
>>>>>>> cc73b2e6c69e71cae38028fb61ad12fa3b2dda01
      ),
    );
  }

<<<<<<< HEAD
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
=======
  Future<DateTime?> _selectDate(BuildContext context, DateTime? initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2033),
    );
  } 
}
>>>>>>> cc73b2e6c69e71cae38028fb61ad12fa3b2dda01
