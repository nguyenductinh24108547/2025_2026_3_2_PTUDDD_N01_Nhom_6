import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  // Dữ liệu giả (Dummy data) cho bài tập trắc nghiệm
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Từ "Apple" nghĩa là gì?',
      'answers': ['Quả cam', 'Quả táo', 'Quả lê', 'Quả dưa'],
      'correctIndex': 1, // Vị trí đáp án đúng (Bắt đầu từ 0)
    },
    {
      'question': 'Từ "Dog" nghĩa là gì?',
      'answers': ['Con mèo', 'Con chim', 'Con chó', 'Con cá'],
      'correctIndex': 2,
    },
  ];

  // Hàm kiểm tra đáp án
  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['correctIndex']) {
      score++; // Trả lời đúng thì cộng 1 điểm
    }

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++; // Chuyển sang câu tiếp theo
      } else {
        // Hết câu hỏi thì hiển thị kết quả
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hoàn thành!'),
            content: Text('Điểm của bạn: $score / ${questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentQuestionIndex = 0; // Reset game
                    score = 0;
                  });
                },
                child: const Text('Chơi lại'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ôn tập (Quiz)'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Câu ${currentQuestionIndex + 1} / ${questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]['question'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
            const SizedBox(height: 40),

            // Dùng vòng lặp để tạo 4 nút bấm
            ...List.generate(
              questions[currentQuestionIndex]['answers'].length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => checkAnswer(index),
                  child: Text(
                    questions[currentQuestionIndex]['answers'][index],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
