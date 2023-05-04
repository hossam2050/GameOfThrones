part of 'app_language_bloc.dart';

@immutable
abstract class AppLanguageEvent {}

class InitialLanguageEvent extends AppLanguageEvent{}
class ArabicLanguageEvent extends AppLanguageEvent{}
class EnglishLanguageEvent extends AppLanguageEvent{}
