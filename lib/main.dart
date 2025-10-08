import 'package:flutter/material.dart';
import 'package:flutter_pr1/ListViewBuilderScreen.dart';
import 'CollumScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Навигация по экранам',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ListViewBuilderScreen(),
    );
  }
}


