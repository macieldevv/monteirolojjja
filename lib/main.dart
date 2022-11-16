import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monteirolojjja/checagem_page.dart';
import 'package:monteirolojjja/firebase_options.dart';
import 'package:monteirolojjja/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const ChecagemPage(),
    );
  }
}
