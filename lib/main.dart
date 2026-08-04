import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/vocabulary_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/setting_screens.dart';

// 1. Khai báo các Notifier quản lý trạng thái toàn cục
final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.light);
final ValueNotifier<Locale> appLocaleNotifier =
    ValueNotifier(const Locale('vi'));
final ValueNotifier<int> scoreNotifier = ValueNotifier(0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Lắng nghe thay đổi của themeNotifier
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        // 3. Lắng nghe thay đổi của appLocaleNotifier
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
              supportedLocales: const [
                Locale('en'),
                Locale('vi'),
              ],

              // 4. Thiết lập giao diện Sáng / Tối toàn ứng dụng
              themeMode: currentTheme,
              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: const Color(
                  0xFFF3F4F6,
                ),
                cardColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color(
                  0xFF121212,
                ),
                cardColor: const Color(0xFF1E1E1E),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF1F1F1F),
                  foregroundColor: Colors.white,
                ),
              ),
              home: const MainScreen(),
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

  final List<Widget> _screens = const [
    HomeScreen(),
    VocabularyScreen(),
    QuizScreen(),
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
            icon: const Icon(Icons.quiz),
            label: l10n.navPractice,
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
