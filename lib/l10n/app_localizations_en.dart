// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get appTitle => 'English Vocabulary App';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get navHome => 'Home';

  @override
  String get navLearn => 'Learn';

  @override
  String get navPractice => 'Practice';

  @override
  String get navSettings => 'Settings';

  @override
  String get goodMorning => 'Good morning, 👋';

  @override
  String get searchHint => 'Search vocabulary, topics...';

  @override
  String get todayProgress => 'Today\'s progress';

  @override
  String get shortcuts => 'Learning shortcuts';
}
