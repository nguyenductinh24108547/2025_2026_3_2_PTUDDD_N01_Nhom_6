import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Vocabulary App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
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

  // Danh sách các màn hình tương ứng với phân công của 3 thành viên[cite: 1]
  final List<Widget> _screens = [
    const HomeScreen(), // Màn hình 1: Trang chủ (Mai Anh Tú code)[cite: 1]
    const PlaceholderScreen(
      title:
          'Màn hình Học - Flashcard\n(Nhiệm vụ của Thành viên 2)',
    ), // Chờ ghép code[cite: 1]
    const PlaceholderScreen(
      title:
          'Màn hình Ôn tập - Quiz\n(Nhiệm vụ của Thành viên 3)',
    ), // Chờ ghép code[cite: 1]
    const PlaceholderScreen(
      title:
          'Màn hình Cài đặt\n(Nhiệm vụ của Thành viên 3)',
    ), // Chờ ghép code[cite: 1]
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Học',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Ôn tập',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 🏠 MÀN HÌNH TRANG CHỦ (PHẦN VIỆC CỦA BẠN - TÚ)[cite: 1]
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Học Từ Vựng Tiếng Anh'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Đã sửa lỗi ở đây!
            children: const [
              Icon(
                Icons.home,
                size: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              Text(
                'Chào mừng bạn đến với App Từ Vựng!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Đây là màn hình Trang chủ của Tú.\nBạn sẽ code danh mục từ vựng và đa ngôn ngữ tại đây.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Màn hình tạm thời hiển thị vị trí chờ lắp ghép code của TV2 và TV3[cite: 1]
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
