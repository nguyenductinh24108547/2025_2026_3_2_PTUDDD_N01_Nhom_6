import 'dart:math';
import 'package:flutter/material.dart';

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
  // Danh sách từ vựng lấy chuẩn theo vocabulary_screen.dart
  final List<Vocabulary> _vocabList = const [
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

  int _currentIndex = 0;
  bool _showFront = true;

  void _flipCard() {
    setState(() {
      _showFront = !_showFront;
    });
  }

  void _nextCard() {
    if (_currentIndex < _vocabList.length - 1) {
      setState(() {
        _currentIndex++;
        _showFront = true;
      });
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _showFront = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _vocabList[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Học Từ Vựng (Flashcard)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Tiến độ học
            Text(
              'Từ ${_currentIndex + 1} / ${_vocabList.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Thẻ Flashcard
            Expanded(
              child: GestureDetector(
                onTap: _flipCard,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        final rotate = Tween(
                          begin: pi,
                          end: 0.0,
                        ).animate(animation);
                        return AnimatedBuilder(
                          animation: rotate,
                          child: child,
                          builder: (context, child) {
                            final isUnder =
                                (ValueKey(_showFront) != child?.key);
                            var tilt =
                                ((animation.value - 0.5).abs() - 0.5) * 0.003;
                            tilt *= isUnder ? -1.0 : 1.0;
                            final value = isUnder
                                ? min(rotate.value, pi / 2)
                                : rotate.value;
                            return Transform(
                              transform: Matrix4.rotationY(value)
                                ..setEntry(3, 2, tilt),
                              alignment: Alignment.center,
                              child: child,
                            );
                          },
                        );
                      },
                  child: _showFront
                      ? _buildFrontCard(currentItem)
                      : _buildBackCard(currentItem),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Nút chuyển thẻ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Thẻ trước'),
                ),
                ElevatedButton.icon(
                  onPressed: _currentIndex < _vocabList.length - 1
                      ? _nextCard
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Thẻ tiếp'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontCard(Vocabulary item) {
    return Card(
      key: const ValueKey(true),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blue.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.touch_app, size: 40, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              item.term,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '(Chạm để xem nghĩa)',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard(Vocabulary item) {
    return Card(
      key: const ValueKey(false),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.orange.shade50,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.definition,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
