import 'package:flutter/material.dart';

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
      home: const HomeScreen(),
    );
  }
}


//Хранилище данных приложения
class AppData {
  static int halfRoundedButtonClicks = 0;           // сколько раз нажали HalfRoundedButton
  static List<String> colorChangingButtonColors = [ // какие цвета бывают у ColorChangingButton
    "Синий",
    "Красный",
  ];
  static bool infoVisited = false;                  // посещали ли экран Инфо
}


//Экран 1 — главный
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Главный экран")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Добро пожаловать!"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ColorButtonScreen()),
                );
              },
              child: const Text("Перейти к ColorChangingButton"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HalfRoundedButtonScreen()),
                );
              },
              child: const Text("Перейти к HalfRoundedButton"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()),
                );
              },
              child: const Text("Инфо экран"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
              child: const Text("Экран настроек"),
            ),
          ],
        ),
      ),
    );
  }
}

//Экран 2 — ColorChangingButton
class ColorButtonScreen extends StatelessWidget {
  const ColorButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ColorChangingButton")),
      body: const Center(
        child: ColorChangingButton(),
      ),
    );
  }
}

class ColorChangingButton extends StatefulWidget {
  const ColorChangingButton({super.key});

  @override
  State<ColorChangingButton> createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  Color _buttonColor = Colors.blue;

  void _changeColor() {
    setState(() {
      _buttonColor = _buttonColor == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      onPressed: _changeColor,
      child: const Text(
        "Нажми меня",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

//Экран 3 — HalfRoundedButton
class HalfRoundedButtonScreen extends StatelessWidget {
  const HalfRoundedButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HalfRoundedButton")),
      body: Center(
        child: HalfRoundedButton(
          text: "Нажми меня",
          onPressed: () {
            AppData.halfRoundedButtonClicks++;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Нажатий: ${AppData.halfRoundedButtonClicks}")),
            );
          },
        ),
      ),
    );
  }
}

class HalfRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HalfRoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
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


//Экран 4 — Информация

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Отмечаем, что экран посещён
    AppData.infoVisited = true;

    return Scaffold(
      appBar: AppBar(title: const Text("Инфо")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Нажатий HalfRoundedButton: ${AppData.halfRoundedButtonClicks}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Цвета ColorChangingButton: ${AppData.colorChangingButtonColors.join(", ")}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Посещали ли экран Инфо: ${AppData.infoVisited ? "Да" : "Нет"}",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}


//Экран 5 — Настройки
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),
      body: const Center(
        child: Text(
          "Здесь могли бы быть ваши настройки приложения!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
