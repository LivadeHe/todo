import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:todo/presentation/item/todo_list_widget.dart';
import 'package:todo/infrastructure/todo_repository.dart';
import 'package:todo/presentation/item/todo_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ToDoController _controller = ToDoController();
  final ToDoRepository _repository = ToDoRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      home: ToDoListWidget(repository: _repository, controller: _controller),
    );
  }
}
=======
import 'presentation/app.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(); 
  runApp(MyApp());
}

/*
Future<void> main() async {
   await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(MyApp());
  
}*/
>>>>>>> cc73b2e6c69e71cae38028fb61ad12fa3b2dda01
