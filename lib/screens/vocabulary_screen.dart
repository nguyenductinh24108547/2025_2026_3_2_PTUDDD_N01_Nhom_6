import 'package:flutter/material.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  // Danh sách từ vựng mẫu
  final List<Map<String, String>> _vocabList = [
    {'word': 'Hello', 'meaning': 'Xin chào'},
    {'word': 'Vocabulary', 'meaning': 'Từ vựng'},
    {'word': 'Developer', 'meaning': 'Nhà phát triển'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Từ vựng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _vocabList.length,
        itemBuilder: (context, index) {
          final item = _vocabList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(
                item['word'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(item['meaning'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
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
        onPressed: () {
          // Xử lý thêm từ vựng mới ở đây
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
