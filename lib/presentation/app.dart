import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/presentation/authenticate/authenticate.dart';


// Klasse ist den Einstiegspunkt von Flutter-Anwendung 
// Hier festlegen: grundlegende Konfigurationen, den App-Titel(Registerkarte), das Theme und den Hauptbildschirm.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo List App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Authenticate(),
    );
  }
}