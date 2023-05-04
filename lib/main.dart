import 'package:flutter/material.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Connectivity/bloc/app_connectivity_bloc.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Languages/bloc/app_language_bloc.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Theme/bloc/app_theme_bloc.dart';
import 'package:flutter_application/Helpers/Observers/appblocobservers.dart';
import 'package:flutter_application/Helpers/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helpers/Route/approuting.dart';
import 'Helpers/lang/applocalizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObservers();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(AppRouting()));
}

class MyApp extends StatelessWidget {
  final AppRouting? appRouting;
  MyApp(this.appRouting);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> AppThemeBloc()..add(InitialThemeEvent())),
        BlocProvider(create:(context)=> AppLanguageBloc()..add(InitialLanguageEvent())),
        BlocProvider(create:(context)=> AppConnectivityBloc()),
        
      ],
      child:Builder(
        builder: (context) {
          var themeState = context.select((AppThemeBloc bloc) => bloc.state);
          var langState = context.select((AppLanguageBloc bloc) => bloc.state);
          var connectivityState = context.select((AppConnectivityBloc bloc) => bloc.state);
          selectedLang = langState is AppChangeLanguage? langState.languageCode == "en"?
          "en":"ar":"en";
          theme = themeState is AppChangeTheme? themeState.appTheme == 'l'?
          "l":"d":"l";
          return MaterialApp(
          onGenerateRoute:appRouting!.generateRoute,
          theme: themeState is AppChangeTheme? themeState.appTheme == 'l'?
          ThemeData.light():ThemeData.dark():ThemeData.light(),
          locale: langState is AppChangeLanguage? langState.languageCode == "en"?
          Locale('en'):Locale('ar') :Locale("en"),
          debugShowCheckedModeBanner: false,
          supportedLocales: [Locale('en'),Locale('ar')],
          title: 'Test',
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
           ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
             for (var locale in supportedLocales) {
              if (deviceLocale != null) {
               if (deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                 }
                }
               }
              return supportedLocales.first;
              },
          );
        }
      )
      
      /*BlocBuilder<AppThemeBloc,AppThemeState>(
        builder: (context, themeState) {
          var theme = themeState is AppChangeTheme ? themeState.appTheme : 'l';
          return BlocBuilder<AppLanguageBloc,AppLanguageState>(
            builder: (context, langState) {
              var lang = langState is AppChangeLanguage ? 
              langState.languageCode :'en';
              return BlocBuilder<AppConnectivityBloc,AppConnectivityState>(
                builder: (context, internetState) {
                  var message = internetState is InternetConnected? 
                  internetState.internetMessage:"Internet Not Connected";
                  return MaterialApp(
                    locale: Locale(lang!),
                    theme: theme == 'l'? ThemeData.light() : ThemeData.dark(),
                                            debugShowCheckedModeBanner: false,
                                            supportedLocales: [
                                              Locale('en'),
                                              Locale('ar'),
                                            ],
                                            title: 'Test',
                                            localizationsDelegates: [
                                              AppLocalizations.delegate,
                                              GlobalMaterialLocalizations.delegate,
                                              GlobalWidgetsLocalizations.delegate,
                                              GlobalCupertinoLocalizations.delegate
                                            ],
                                            localeResolutionCallback: (deviceLocale, supportedLocales) {
                                              for (var locale in supportedLocales) {
                                                if (deviceLocale != null) {
                                                  if (deviceLocale.languageCode == locale.languageCode) {
                                                    return deviceLocale;
                                                  }
                                                }
                                              }
                                              return supportedLocales.first;
                                            },
                                            home: Home(message:message!,));
                },
              );
            },
          );
        },
      )*/
      );
  }
}
