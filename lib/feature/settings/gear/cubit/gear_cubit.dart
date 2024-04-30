import 'package:bloc/bloc.dart';
import 'package:cepdovizapp/core%20/enums/enums.dart';
import 'package:cepdovizapp/core%20/shared_preferences/constans/shared_preferences.dart';

import 'gear_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  void changeLanguage(LanguagesTypesEnums language) {
    switch (language) {
      case LanguagesTypesEnums.initial:
        if (SharedPreferencesHelper.getData('lang') != null) {
          if (SharedPreferencesHelper.getData('lang') == 'tr') {
            emit(ChangeAppLanguage(languageCode: 'tr'));
          } else {
            emit(ChangeAppLanguage(languageCode: 'en'));
          }
        }
        break;
      case LanguagesTypesEnums.turkey:
        SharedPreferencesHelper.setData('lang', '');
        emit(ChangeAppLanguage(languageCode: 'tr'));
        break;
      case LanguagesTypesEnums.english:
        SharedPreferencesHelper.setData('lang', 'en');
        emit(ChangeAppLanguage(languageCode: 'en'));
        break;
      default:
        emit(ChangeAppLanguage(languageCode: 'en'));
    }
  }
}
