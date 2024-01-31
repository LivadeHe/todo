import 'package:cloud_firestore/cloud_firestore.dart';

// DEFINITION VON ITEM

class Item {
  String id;
  String title;
  bool isDone;
  int? day;
  int? month;
  int? year;
  String? userId;

  Item({required this.id, required this.title, this.isDone = false, this.day, this.month, this.year, this.userId} );

  // Konstruktur zum erstellen Item-Objekt aus Firebase-Daten 
  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      title: data['title'],
      isDone: data['isDone'],
      day: data['day'],
      month: data['month'],
      year: data['year'],
      userId: data['userId']
    );
  }

  // Methode um Item-Objekt in einem JSON-Objekt zu verwandeln für Firebase
  Map<String, dynamic> toJson() {
      return {
        'title': title,
        'isDone': isDone,
        'day': day,
        'month': month,
        'year': year,
        'userId': userId,
      };
    }

}