import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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