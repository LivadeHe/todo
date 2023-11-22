// Definition von Item

class Item {
  String id;
  String title;
  bool isDone;
  int? day;
  int? month;
  int? year;

  Item({required this.id, required this.title, this.isDone = false, this.day, this.month, this.year} );
}