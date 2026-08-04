import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Từ "Apple" nghĩa là gì?',
      'options': ['Con chó', 'Quả táo', 'Nước uống', 'Cái cây'],
      'answerIndex': 1,
    },
    {
      'question': 'Từ "Banana" nghĩa là gì?',
      'options': ['Quả chuối', 'Con mèo', 'Quyển sách', 'Xe ô tô'],
      'answerIndex': 0,
    },
    {
      'question': 'Từ "Cat" nghĩa là gì?',
      'options': ['Ngôi nhà', 'Quả táo', 'Con mèo', 'Mặt trời'],
      'answerIndex': 2,
    },
    {
      'question': 'Từ "Dog" nghĩa là gì?',
      'options': ['Xe ô tô', 'Nước uống', 'Quả chuối', 'Con chó'],
      'answerIndex': 3,
    },
    {
      'question': 'Từ "Book" nghĩa là gì?',
      'options': ['Quyển sách', 'Mặt trời', 'Cái cây', 'Ngôi nhà'],
      'answerIndex': 0,
    },
    {
      'question': 'Từ "Car" nghĩa là gì?',
      'options': ['Quả táo', 'Xe ô tô', 'Con chó', 'Nước uống'],
      'answerIndex': 1,
    },
    {
      'question': 'Từ "Sun" nghĩa là gì?',
      'options': ['Cái cây', 'Con mèo', 'Mặt trời', 'Quả chuối'],
      'answerIndex': 2,
    },
    {
      'question': 'Từ "Water" nghĩa là gì?',
      'options': ['Quyển sách', 'Ngôi nhà', 'Mặt trời', 'Nước uống'],
      'answerIndex': 3,
    },
    {
      'question': 'Từ "House" nghĩa là gì?',
      'options': ['Ngôi nhà', 'Quả táo', 'Xe ô tô', 'Cái cây'],
      'answerIndex': 0,
    },
    {
      'question': 'Từ "Tree" nghĩa là gì?',
      'options': ['Con mèo', 'Cái cây', 'Nước uống', 'Quyển sách'],
      'answerIndex': 1,
    },
  ];

  int currentIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool isAnswered = false;

  void checkAnswer(int index) {
    if (isAnswered) return;

    setState(() {
      selectedAnswer = index;
      isAnswered = true;
      if (index == questions[currentIndex]['answerIndex']) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedAnswer = null;
          isAnswered = false;
        });
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Kết quả'),
            content: Text('Bạn đã làm đúng $score/${questions.length} câu.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentIndex = 0;
                    score = 0;
                    selectedAnswer = null;
                    isAnswered = false;
                  });
                },
                child: const Text('Làm lại'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQ = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ôn tập'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Câu ${currentIndex + 1}/${questions.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Điểm: $score',
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  currentQ['question'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: currentQ['options'].length,
                itemBuilder: (context, index) {
                  bool isCorrect = index == currentQ['answerIndex'];
                  bool isSelected = index == selectedAnswer;

                  Color boxColor = Colors.white;
                  Color borderColor = Colors.grey;

                  if (isAnswered) {
                    if (isCorrect) {
                      boxColor = Colors.green.shade100;
                      borderColor = Colors.green;
                    } else if (isSelected) {
                      boxColor = Colors.red.shade100;
                      borderColor = Colors.red;
                    }
                  }

                  return GestureDetector(
                    onTap: () => checkAnswer(index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: boxColor,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        currentQ['options'][index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
