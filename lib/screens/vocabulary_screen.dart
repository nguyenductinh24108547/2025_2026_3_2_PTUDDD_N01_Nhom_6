import 'package:flutter/material.dart';
import '../models/vocabulary.dart';
import '../main.dart'; // Đồng bộ appLocaleNotifier

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  final List<Vocabulary> sampleVocabularies = const [
    Vocabulary(
      id: '1',
      term: 'Apple',
      definition: 'Quả táo',
    ),
    Vocabulary(
      id: '2',
      term: 'Banana',
      definition: 'Quả chuối',
    ),
    Vocabulary(id: '3', term: 'Cat', definition: 'Con mèo'),
    Vocabulary(id: '4', term: 'Dog', definition: 'Con chó'),
    Vocabulary(
      id: '5',
      term: 'Book',
      definition: 'Quyển sách',
    ),
    Vocabulary(id: '6', term: 'Car', definition: 'Xe ô tô'),
    Vocabulary(
      id: '7',
      term: 'Sun',
      definition: 'Mặt trời',
    ),
    Vocabulary(
      id: '8',
      term: 'Water',
      definition: 'Nước uống',
    ),
    Vocabulary(
      id: '9',
      term: 'House',
      definition: 'Ngôi nhà',
    ),
    Vocabulary(
      id: '10',
      term: 'Tree',
      definition: 'Cái cây',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        appLocaleNotifier.value.languageCode == 'en';
    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEnglish
              ? 'Vocabulary Management'
              : 'Quản lý Từ vựng',
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleVocabularies.length,
        separatorBuilder: (context, index) => Divider(
          color: isDark
              ? Colors.grey.shade800
              : Colors.grey.shade300,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final vocab = sampleVocabularies[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: isDark
                  ? Colors.blue.shade900
                  : Colors.blue.shade100,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isDark
                      ? Colors.blue.shade200
                      : Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              vocab.term,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              vocab.definition,
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
              ),
            ),
          );
        },
      ),
    );
  }
}
