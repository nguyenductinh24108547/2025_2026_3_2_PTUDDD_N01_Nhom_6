<<<<<<< HEAD
import 'screens/vocabulary_screen.dart';
=======
>>>>>>> nhom/main
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart'; // Đã nhúng file Ôn tập của Tính
import 'screens/setting_screens.dart'; // Đã nhúng file Cài đặt của Tính

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Vocabulary App',
      theme: ThemeData(primaryColor: Colors.blue, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Đã cắm 2 màn hình của bạn vào đúng vị trí số 3 và 4
  final List<Widget> _screens = [
<<<<<<< HEAD
    const PlaceholderScreen(title: 'Trang chủ'),
    const VocabularyScreen(), // <--- Màn hình Quản lý từ vựng của bạn
    const PlaceholderScreen(title: 'Ôn tập'),
    const PlaceholderScreen(title: 'Cài đặt'),
=======
    const HomeScreen(),
    const PlaceholderScreen(
      title: 'Màn hình Học - Flashcard\n(Nhiệm vụ của Thành viên 2)',
    ),
    const QuizScreen(), // Màn hình Ôn tập (Thành viên 3)
    const SettingScreens(), // Màn hình Cài đặt (Thành viên 3)
>>>>>>> nhom/main
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Học'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Ôn tập'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}

// Màn hình tạm thời hiển thị vị trí chờ lắp ghép code của TV2
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khu vực chờ ghép code'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
