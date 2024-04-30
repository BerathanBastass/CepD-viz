import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale? locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  late Map<String, String> jsonStrings;

  Future loadLang() async {
    try {
      String langFilePath = await rootBundle
          .loadString('assets/translations/${locale!.languageCode}.json');
      Map<String, dynamic> decodedJson = json.decode(langFilePath);
      jsonStrings = decodedJson.map((key, value) {
        return MapEntry(key, value.toString());
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  String translate(String key) {
    return jsonStrings[key] ?? 'No translation found for $key';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['tr', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadLang();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
