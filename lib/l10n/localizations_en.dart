import 'localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Hi+BOSS';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get invalidPhone => 'Invalid phone number';

  @override
  String get emailNotFound => 'Email not found';

  @override
  String get phoneNotFound => 'Phone number not found';

  @override
  String get or => 'hoặc';
}
