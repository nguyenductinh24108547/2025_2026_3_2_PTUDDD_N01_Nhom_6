import 'package:flutter/material.dart';
import '../models/vocabulary.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final List<Vocabulary> _vocabList = [
    Vocabulary(id: '1', term: 'Widget', definition: 'Thành phần giao diện cơ bản trong Flutter', example: 'Text là một Widget.'),
    Vocabulary(id: '2', term: 'StatefulWidget', definition: 'Widget có thể thay đổi trạng thái', example: 'Dùng khi dữ liệu biến đổi.'),
    Vocabulary(id: '3', term: 'StatelessWidget', definition: 'Widget tĩnh, không đổi trạng thái', example: 'Dùng cho màn hình tĩnh.'),
  ];

  void _addVocabulary(String term, String definition) {
    setState(() {
      _vocabList.add(Vocabulary(
        id: DateTime.now().toString(),
        term: term,
        definition: definition,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách từ vựng'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _vocabList.length,
        itemBuilder: (ctx, index) {
          final item = _vocabList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(item.term, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.definition),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _vocabList.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final termController = TextEditingController();
    final defController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Thêm từ mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: termController, decoration: const InputDecoration(labelText: 'Từ mới')),
            TextField(controller: defController, decoration: const InputDecoration(labelText: 'Định nghĩa')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              if (termController.text.isNotEmpty && defController.text.isNotEmpty) {
                _addVocabulary(termController.text, defController.text);
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
}
