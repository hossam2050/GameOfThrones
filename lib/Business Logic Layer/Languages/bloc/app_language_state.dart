part of 'app_language_bloc.dart';

@immutable
abstract class AppLanguageState {}

class AppLanguageInitial extends AppLanguageState {}

class AppChangeLanguage extends AppLanguageState {
  final String? languageCode;

  AppChangeLanguage({this.languageCode});

}
