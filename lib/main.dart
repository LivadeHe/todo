import 'package:flutter/material.dart';
import 'todo_list.dart'; 

void main() {
  runApp(MyApp(title: 'ToDo List'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.teal, 
      ),
      home: MyHomePage(),
    );
  }
  }

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Hier können Sie die gewünschte Textrichtung festlegen
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My ToDoList"),
      ),
      body: ToDoListWidget(), 
      ),
    );
  }

}