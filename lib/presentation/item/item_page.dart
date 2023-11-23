import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/presentation/item/item_controller.dart';
import '../../infrastructure/item.dart';

// Hinzufügen neuer Element


class ItemPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime? initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2033),
    );
  } 
}