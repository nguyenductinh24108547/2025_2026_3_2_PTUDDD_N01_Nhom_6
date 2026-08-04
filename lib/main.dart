import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/vocabulary_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/setting_screens.dart';
import 'screens/flashcard_screen.dart';
import 'screens/group_info_screen.dart';

// 1. Khai báo các ValueNotifier quản lý trạng thái toàn cục
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Color> appColorNotifier = ValueNotifier(
  const Color(0xFF2196F3),
);
final ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(
  const Locale('vi'),
);
final ValueNotifier<int> scoreNotifier = ValueNotifier(0);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return ValueListenableBuilder<Color>(
          valueListenable: appColorNotifier,
          builder: (context, currentColor, child) {
            return ValueListenableBuilder<Locale>(
              valueListenable: appLocaleNotifier,
              builder: (context, currentLocale, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: currentLocale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [Locale('en'), Locale('vi')],
                  themeMode: currentTheme,
                  theme: ThemeData(
                    brightness: Brightness.light,
                    primaryColor: currentColor,
                    scaffoldBackgroundColor: const Color(0xF2F5F8),
                    cardColor: Colors.white,
                    appBarTheme: AppBarTheme(
                      backgroundColor: currentColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: currentColor,
                    scaffoldBackgroundColor: const Color(0xFF121212),
                    cardColor: const Color(0xFF1E1E1E),
                    appBarTheme: AppBarTheme(
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  home: const MainScreen(),
                );
              },
            );
          },
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

  // 2. Đã thêm FlashcardScreen và GroupInfoScreen vào danh sách màn hình
  final List<Widget> _screens = const [
    HomeScreen(),
    VocabularyScreen(),
    FlashcardScreen(),
    QuizScreen(),
    GroupInfoScreen(),
    SettingScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: l10n.navLearn,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.style),
            label: appLocaleNotifier.value.languageCode == 'en'
                ? 'Flashcard'
                : 'Thẻ từ',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.quiz),
            label: l10n.navPractice,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: appLocaleNotifier.value.languageCode == 'en'
                ? 'Group'
                : 'Nhóm',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
