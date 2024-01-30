import 'package:get/get.dart';
import '../../infrastructure/item.dart';
import '../../infrastructure/item_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/infrastructure/item_repository.dart';


// VERANTWORTLICH FÜR ZUSTAND DES ITEMS 
// Methode wie add, delete, update etc. 


class ItemController extends GetxController {
  final ItemRepository _itemRepository = ItemRepository();

  //Alt:
  //List<Item> get items => _itemRepository.items;
  RxList<Item> items = <Item>[].obs;
  // RxList ermöglicht eine einfache aktualisierung von UIs bei Änderung in/an der Liste

  // TODO DELETE?
  //final CollectionReference itemsCollection = FirebaseFirestore.instance.collection('items');


  // Lädt die Elemente aus Firebase beim Initialisieren vom Controller
  // onInit wird aufgerufen, wenn Controller erstellt wird. lädt die Items aus dem Firebase(db), 
  // 

   @override
  void onInit() {  
    _loadItems();
    super.onInit();
  }

  // Nutzt die Stream von ItemRepository, damit die Liste automatisch aktualisiert wird
  void _loadItems() {
    _itemRepository.getItems().listen((List<Item> data) {
      items.assignAll(data);
      update();
    });
  }


  // async / await --> aktualisiert die UI erst NACH Abschluss der DB-Operation 

  /*
  void addItem(Item item) {
    _itemRepository.addItem(item);
    update();
  }
  */
  Future<void> addItem(Item item) async {
    await _itemRepository.addItem(item);
    update();
  }


  /*
  void toggleTaskState(Item item) {
    item.isDone = !item.isDone;
    update();
  }
  */
  Future<void> toggleTaskState(Item item) async {
    await _itemRepository.toggleTaskState(item);
    update();
  }

  /*
  void editItem(Item item, String newTitle, DateTime? newDueDate) {
    item.title = newTitle;
    item.day = newDueDate?.day;
    item.month = newDueDate?.month;
    item.year = newDueDate?.year;
    update();
  }
  */

    Future<void> editItem(Item item, String newTitle, DateTime? newDueDate) async {
    await _itemRepository.updateItem(item, newTitle, newDueDate);
    update();
  }


  /*
  void deleteItem(Item item) {
    _itemRepository.deleteItem(item);
    update();
  }
  */
  Future<void> deleteItem(Item item) async {
    await _itemRepository.deleteItem(item);
    update();
  }

  // Alle Items aus Firebase abrufen
Stream<List<Item>> getItems() {
  return _itemRepository.getItems();
}

}
