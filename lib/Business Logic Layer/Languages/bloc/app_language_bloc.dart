import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Helpers/constants.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc() : super(AppLanguageInitial()) {
    on<AppLanguageEvent>((event, emit) {
      if(event is InitialLanguageEvent){
        if(sharedPreferences!.getString('lang') != null){
          if(sharedPreferences!.getString('lang') == 'ar'){
            emit(AppChangeLanguage(languageCode: 'ar'));
          }
          else{
            emit(AppChangeLanguage(languageCode: 'en'));
          }
        }
      }
      else if(event is ArabicLanguageEvent){
        sharedPreferences!.setString('lang', 'ar');
        emit(AppChangeLanguage(languageCode: 'ar'));
      }
      else if(event is EnglishLanguageEvent){
        sharedPreferences!.setString('lang', 'en');
        emit(AppChangeLanguage(languageCode: 'en'));
      }
    });
  }
}
