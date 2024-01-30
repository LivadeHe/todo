import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/presentation/item/item_controller.dart';
import '../../infrastructure/item.dart';
import 'package:intl/intl.dart';

// Die Darstellung ein einzelnen Item (Element) in der Liste
// Die Klasse kann Steuerelement für Aktionen wie Löschen eines Element erhalten


class ItemTile extends StatelessWidget {
  final Item item;

  ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
     Color backgroundColor = _getBackgroundColor(item);

    return Container(
      color: backgroundColor,
      child: ListTile(
      title: Text(
        item.title,

        style: TextStyle(
          decoration: item.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: item.day != null && item.month != null && item.year != null
          ? Text("Due Date: ${DateFormat('dd.MM.yyyy').format(DateTime(item.year!, item.month!, item.day!))}")
          : null,
      leading: Checkbox(
        value: item.isDone,
        onChanged: (bool? value) { 

          Get.find<ItemController>().toggleTaskState(item);
         
          },
),
      trailing:  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, item);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Get.find<ItemController>().deleteItem(item);
            },
          ),
        ],
      ),
      ),
    );
      
  }
      
    

  Future<void> _showEditDialog(BuildContext context, Item item) async {
  String editedTitle = item.title;
  DateTime? editedDueDate = item.day != null && item.month != null && item.year != null
      ? DateTime(item.year!, item.month!, item.day!)
      : null;

  TextEditingController dateController = TextEditingController(
    text: editedDueDate != null ? DateFormat('dd.MM.yyyy').format(editedDueDate) : '',
  );    

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                editedTitle = value;
              },
              controller: TextEditingController(text: item.title),
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate = await _selectDate(context, editedDueDate);
                    if (selectedDate != null) {
                      editedDueDate = selectedDate;
                      dateController.text = DateFormat('dd.MM.yyyy').format(editedDueDate!);
                    }
                    //setState((){});
              },
              child: Text('Select Due Date'),
            ),
            // TODO: Neue ausgewählter Datum anzeigen lassen --> statefulwidget
            /*SizedBox(height: 16),
            Text(
              "Selected Due Date: ${dateController.text}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            */
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {

              Get.find<ItemController>().editItem(item, editedTitle, editedDueDate);
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
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

  Color _getBackgroundColor(Item item) {
    DateTime now = DateTime.now();
    DateTime dueDate = DateTime(item.year!, item.month!, item.day!);

    now = DateTime(now.year, now.month, now.day);

    if (dueDate.isBefore(now)) {
      return Colors.blue.shade200;
    } else if (dueDate.difference(now).inDays == 0) {
      return Colors.yellow.shade200; 
    } else {
      return Colors.purple.shade200; 
    }
  }


}