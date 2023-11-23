import 'item.dart';

// Diese Klasse ist verantwortlich für die Verwaltung der Datenquelle

class ItemRepository {
  List<Item> items = [];

  // Methoden zum adden, updatem, deleten etc 

  void addItem(Item item) {
    items.add(item);
  }


  void deleteItem(Item item) {
    items.remove(item);
  }


  void toggleTaskState(Item item) {
    item.isDone = !item.isDone;
  }


  void editItem(Item item, String newTitle, DateTime? newDueDate) {
  
    final index = items.indexOf(item);
    if (index != -1) {
      items[index].title = newTitle;
        items[index].title = newTitle;
        items[index].day = newDueDate?.day;
        items[index].month = newDueDate?.month;
        items[index].year = newDueDate?.year;
    }
  }
}