import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart';

// Diese Klasse ist verantwortlich für die Verwaltung der Datenquelle

class ItemRepository {

  //List<Item> items = []; 

  //final String itemId;
  //ItemRepository( {required this.itemId} );

  final CollectionReference itemCollection = FirebaseFirestore.instance.collection('items');
  
  // Methoden zum adden, updatem, deleten etc 

  // Ein Element zu Firestore hinzufügen:
  /*
  void addItem(Item item) {
    items.add(item);
  }
  */

  Future<void> addItem(Item item) async {
    await itemCollection.add(item.toJson());
  }


  // Löschen alt
  /*
  void deleteItem(Item item) {
    items.remove(item);
  }
  */

  // Löschen alt
  Future<void> deleteItem(Item item) async {
    await itemCollection.doc(item.id).delete();
  }


  // Auf erledigt setzen alt:
  /*
  void toggleTaskState(Item item) {
    item.isDone = !item.isDone;
  }
  */

  Future<void> toggleTaskState(Item item) async {
    await itemCollection.doc(item.id).update({'isDone': !item.isDone});
  }


  // Bearbeiten alt:
  /*
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
  */

  Future<void> updateItem(Item item, String newTitle, DateTime? newDueDate) async {
    await itemCollection.doc(item.id).update({
      'title': newTitle,
      'day': newDueDate?.day,
      'month': newDueDate?.month,
      'year': newDueDate?.year,
    });
  }


  // Alle Items aus Firestore abrufen:
  Stream<List<Item>> getItems() {
    return itemCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
    });
  }

}