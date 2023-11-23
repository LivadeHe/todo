import 'package:get/get.dart';
import '../../infrastructure/item.dart';
import '../../infrastructure/item_repository.dart';

// Verantwortlich für Zustand des Items 
// Methode wie add, delete, update etc. 


class ItemController extends GetxController {
  ItemRepository _itemRepository = ItemRepository();

  List<Item> get items => _itemRepository.items;

  void addItem(Item item) {
    _itemRepository.addItem(item);
    update();
  }

  void toggleTaskState(Item item) {
    item.isDone = !item.isDone;
    update();
  }

  void editItem(Item item, String newTitle, DateTime? newDueDate) {
    item.title = newTitle;
    item.day = newDueDate?.day;
    item.month = newDueDate?.month;
    item.year = newDueDate?.year;
    update();
  }



  void deleteItem(Item item) {
    _itemRepository.deleteItem(item);
    update();
  }

}
