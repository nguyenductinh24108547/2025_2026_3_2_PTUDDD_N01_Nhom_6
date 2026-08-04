import 'package:flutter/material.dart';
import '../main.dart';

class Vocabulary {
  final String id;
  final String term;
  final String definition;

  const Vocabulary({
    required this.id,
    required this.term,
    required this.definition,
  });
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final List<Vocabulary> sampleVocabularies = const [
    Vocabulary(id: '1', term: 'Apple', definition: 'Quả táo'),
    Vocabulary(id: '2', term: 'Banana', definition: 'Quả chuối'),
    Vocabulary(id: '3', term: 'Cat', definition: 'Con mèo'),
    Vocabulary(id: '4', term: 'Dog', definition: 'Con chó'),
    Vocabulary(id: '5', term: 'Book', definition: 'Quyển sách'),
    Vocabulary(id: '6', term: 'Car', definition: 'Xe ô tô'),
    Vocabulary(id: '7', term: 'Sun', definition: 'Mặt trời'),
    Vocabulary(id: '8', term: 'Water', definition: 'Nước uống'),
    Vocabulary(id: '9', term: 'House', definition: 'Ngôi nhà'),
    Vocabulary(id: '10', term: 'Tree', definition: 'Cái cây'),
  ];

  int currentIndex = 0;
  bool isFlipped = false;
  void _nextCard() {
    if (currentIndex < sampleVocabularies.length - 1) {
      setState(() {
        currentIndex++;
        isFlipped = false;
      });
    }
  }

  void _previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        isFlipped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, locale, child) {
        final bool isEnglishApp = locale.languageCode == 'en';
        final currentItem = sampleVocabularies[currentIndex];

        final String frontText = isEnglishApp
            ? currentItem.term
            : currentItem.definition;
        final String backText = isEnglishApp
            ? currentItem.definition
            : currentItem.term;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isEnglishApp ? 'Vocabulary Flashcard' : 'Học Từ Vựng (Flashcard)',
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  isEnglishApp
                      ? 'Word ${currentIndex + 1} / ${sampleVocabularies.length}'
                      : 'Từ ${currentIndex + 1} / ${sampleVocabularies.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFlipped = !isFlipped;
                      });
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: isFlipped
                          ? Colors.orange.shade50
                          : Colors.blue.shade50,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isFlipped ? Icons.translate : Icons.touch_app,
                              size: 48,
                              color: isFlipped ? Colors.orange : Colors.blue,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              isFlipped ? backText : frontText,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: isFlipped
                                    ? Colors.orange.shade800
                                    : Colors.blue.shade800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              isFlipped
                                  ? (isEnglishApp
                                        ? '(Vietnamese Meaning)'
                                        : '(Nghĩa Tiếng Anh)')
                                  : (isEnglishApp
                                        ? '(Tap to see meaning)'
                                        : '(Chạm để xem nghĩa)'),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: currentIndex > 0 ? _previousCard : null,
                      icon: const Icon(Icons.arrow_back),
                      label: Text(isEnglishApp ? 'Previous' : 'Thẻ trước'),
                    ),
                    ElevatedButton.icon(
                      onPressed: currentIndex < sampleVocabularies.length - 1
                          ? _nextCard
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(isEnglishApp ? 'Next' : 'Thẻ tiếp'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
