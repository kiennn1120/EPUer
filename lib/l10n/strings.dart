import 'package:flutter/material.dart';

import 'localizations.dart';

class Strings {
  late final BuildContext context;

  Strings.of(BuildContext context) {
    this.context = context;
  }

  String get appName => AppLocalizations.of(context)!.appName;
  String get invalidEmail => AppLocalizations.of(context)!.invalidEmail;
  String get invalidPhone => AppLocalizations.of(context)!.invalidPhone;
  String get emailNotFound => AppLocalizations.of(context)!.emailNotFound;
  String get phoneNotFound => AppLocalizations.of(context)!.phoneNotFound;
  String get or => AppLocalizations.of(context)!.or;
}
