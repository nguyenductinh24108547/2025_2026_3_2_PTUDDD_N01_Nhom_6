import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/setting_screens.dart';

// Biến ValueNotifier giúp thông báo đổi ngôn ngữ cho toàn App
final ValueNotifier<Locale> appLocaleNotifier =
    ValueNotifier(const Locale('vi'));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, child) {
        return MaterialApp(
          title: 'English Vocabulary App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue,
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          locale:
              currentLocale, // Tự động cập nhật khi appLocaleNotifier thay đổi
          home: const MainScreen(),
        );
      },
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
    const HomeScreen(),
    const PlaceholderScreen(
      title:
          'Màn hình Học - Flashcard\n(Nhiệm vụ của Thành viên 2)',
    ),
    const QuizScreen(), // Màn hình Ôn tập (Thành viên 3)
    const SettingScreens(), // Màn hình Cài đặt (Thành viên 3)
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: l10n.navLearn,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: l10n.navPractice,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: l10n.navSettings,
          ),
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
