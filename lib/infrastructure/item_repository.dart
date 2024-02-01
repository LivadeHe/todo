import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart';

// Diese Klasse ist verantwortlich für die Verwaltung der Datenquelle

class ItemRepository {

  final CollectionReference itemCollection = FirebaseFirestore.instance.collection('items');
  
  // Methoden zum adden, updatem, deleten etc 
  Future<void> addItem(Item item) async {
    await itemCollection.add(item.toJson());
  }

  Future<void> deleteItem(Item item) async {
    await itemCollection.doc(item.id).delete();
  }

  Future<void> toggleTaskState(Item item) async {
    await itemCollection.doc(item.id).update({'isDone': !item.isDone});
  }

  Future<void> updateItem(Item item, String newTitle, DateTime? newDueDate) async {
    await itemCollection.doc(item.id).update({
      'title': newTitle,
      'day': newDueDate?.day,
      'month': newDueDate?.month,
      'year': newDueDate?.year,
    });
  }

  // Alle Items aus Firestore abrufen
  Stream<List<Item>> getItems(String userId) {
    return itemCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
      }
    );
  }

}