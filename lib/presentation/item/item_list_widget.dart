import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'item_page.dart';
import 'item_controller.dart';
import 'item_tile.dart';


// Hauptbildschirm mit Liste der Elemente
// GetBuilder<ItemController> --> überwacht Änderungen im Itemcontroller & aktualisiert die Liste

class ItemListWidget extends StatelessWidget {
  final String userId;

  ItemListWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemController(userId: userId));
    double buttonWidth = MediaQuery.of(context).size.width * 0.5;
    double buttonHeight = MediaQuery.of(context).size.width * 0.05;

  Get.put(ItemController(userId: userId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Important To-Do-List'),
      ),
      body: GetBuilder<ItemController>(
        init: ItemController(userId: userId),
        builder: (controller) => ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return ItemTile(item: controller.items[index]);
          },
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
        ),
      ),
 floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Get.to(ItemPage());
        },
        icon: Icon(Icons.add),
        label: Text('Add ToDo'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16.0), 
          minimumSize: Size(buttonWidth, buttonHeight),
        ),
      ),
    );
  }
}
