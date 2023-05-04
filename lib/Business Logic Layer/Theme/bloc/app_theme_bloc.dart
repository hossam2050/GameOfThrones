import 'package:bloc/bloc.dart';
import 'package:flutter_application/Helpers/constants.dart';
import 'package:meta/meta.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(AppThemeInitial()) {
    on<AppThemeEvent>((event, emit) {
      if(event is InitialThemeEvent){
        if(sharedPreferences!.getString('theme') != null){
          if(sharedPreferences!.getString('theme') == 'l'){
            emit(AppChangeTheme(appTheme: 'l'));
          }
          else{
            emit(AppChangeTheme(appTheme: 'd'));
          }
        }
      }
      else if(event is LightThemeEvent){
        sharedPreferences!.setString('theme', 'l');
        emit(AppChangeTheme(appTheme: 'l'));
      }
      else if(event is DarkThemeEvent){
        sharedPreferences!.setString('theme', 'd');
        emit(AppChangeTheme(appTheme: 'd'));
      }
    });
  }
}
