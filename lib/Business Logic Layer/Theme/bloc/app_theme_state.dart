part of 'app_theme_bloc.dart';

@immutable
abstract class AppThemeState {}

class AppThemeInitial extends AppThemeState {}

class AppChangeTheme extends AppThemeState {
  final String? appTheme;

  AppChangeTheme({this.appTheme});
}
