import 'localizations.dart';

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Hi+BOSS';

  @override
  String get invalidEmail => 'Email không hợp lệ';

  @override
  String get invalidPhone => 'Số điện thoại không hợp lệ';

  @override
  String get emailNotFound => 'Email không đúng';

  @override
  String get phoneNotFound => 'Số điện thoại không đúng';

  @override
  String get or => 'hoặc';
}
