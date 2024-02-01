import 'package:get/get.dart';
import '../../infrastructure/item.dart';
import '../../infrastructure/item_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


// VERANTWORTLICH FÜR ZUSTAND DES ITEMS 
// Methode wie add, delete, update etc. 


class ItemController extends GetxController {
  final ItemRepository _itemRepository = ItemRepository();
  RxList<Item> items = <Item>[].obs;
  String userId;
  ItemController({required this.userId});
  
   @override
  void onInit() {  
    _loadItems();
    super.onInit();
  }

  // Nutzt die Stream von ItemRepository, damit die Liste automatisch aktualisiert wird
  void _loadItems() {
    _itemRepository.getItems(userId).listen((List<Item> data) {
      items.assignAll(data);
      update();
    });
  }
  
  Future<void> addItem(Item item) async {
    item.userId = FirebaseAuth.instance.currentUser?.uid;
    await _itemRepository.addItem(item);
    update();
  }

  Future<void> toggleTaskState(Item item) async {
    await _itemRepository.toggleTaskState(item);
    update();
  }

  Future<void> editItem(Item item, String newTitle, DateTime? newDueDate) async {
    await _itemRepository.updateItem(item, newTitle, newDueDate);
    update();
  }

  Future<void> deleteItem(Item item) async {
    await _itemRepository.deleteItem(item);
    update();
  }

  // Alle Items aus Firebase abrufen
  Stream<List<Item>> getItems() {
    return _itemRepository.getItems(userId);
  }

}
