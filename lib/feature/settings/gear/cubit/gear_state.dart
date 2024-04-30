import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class ChangeAppLanguage extends LocalizationState {
  final String? languageCode;

  ChangeAppLanguage({this.languageCode});
}

class LocalizationStates extends Equatable {
  final String languageCode;

  const LocalizationStates({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}
