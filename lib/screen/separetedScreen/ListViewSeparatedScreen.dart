import 'package:flutter/material.dart';
import '../../features/Elements.dart';

class ListViewSeparatedScreen extends StatefulWidget {
  const ListViewSeparatedScreen({super.key});

  @override
  State<ListViewSeparatedScreen> createState() => _ListViewSeparatedScreenState();
}
class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
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
      appBar: AppBar(title: const Text("Список элементов")),
      body: Column(
        children: [
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: elements.length,
              itemBuilder: (context, index) {
                final item = elements[index];
                return Padding(
                  key: item["key"],
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black38,
                thickness: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}