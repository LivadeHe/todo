import 'package:flutter/material.dart';
import 'presentation/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(); 
  runApp(MyApp());
}


// test@test.com PW test1234
// lisa@lisa.com PW lisa1234
// markus@markus.com PW markus1234