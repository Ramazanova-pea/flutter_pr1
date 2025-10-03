import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практика 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Кнопка в центре")),
      body: Center(
        child: HalfRoundedButton(
            text: "text",
            onPressed: (){
              print("Кнопка нажата!");
            }
        ),
      )
    );
  }
}

class HalfRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HalfRoundedButton ({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          )
        )
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


