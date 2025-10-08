import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColumnScreen extends StatefulWidget {
  const ColumnScreen({super.key});

  @override
  State<ColumnScreen> createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  // список элементов
  final List<Map<String, dynamic>> elements = [
    {"code": "А0", "content": "Контекст", "selected": false},
    {"code": "А1", "content": "Первая функция", "selected": false},
    {"code": "А2", "content": "Вторая функция", "selected": false},
  ];

  // метод для показа диалога добавления
  void _showAddDialog() {
    final codeController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Добавить элемент"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: "Код"),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: "Описание"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),
            ElevatedButton(
              onPressed: () {
                if (codeController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  setState(() {
                    elements.add({
                      "code": codeController.text,
                      "content": contentController.text,
                      "selected": false,
                    });
                  });
                  Navigator.pop(context); // закрыть диалог
                }
              },
              child: const Text("Добавить"),
            ),
          ],
        );
      },
    );
  }

  // метод для удаления отмеченных элементов
  void _deleteSelected() {
    setState(() {
      elements.removeWhere((item) => item["selected"] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Пример использования Column")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LeftRoundedButton(
                  text: "Добавить элемент",
                  onPressed: _showAddDialog,
                ),
                RightRoundedButton(
                  text: "Удалить элемент",
                  onPressed: _deleteSelected,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: elements.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElementIDEF(
                        code: item["code"]!,
                        content: item["content"]!,
                        selected: item["selected"]!,
                        onChanged: (value) {
                          setState(() {
                            item["selected"] = value;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ElementIDEF extends StatelessWidget {
  final String code;
  final String content;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  const ElementIDEF({
    super.key,
    required this.code,
    required this.content,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          Checkbox(value: selected, onChanged: onChanged),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeftRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LeftRoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class RightRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RightRoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
