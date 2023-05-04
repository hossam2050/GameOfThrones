import 'package:flutter_application/Data%20Layer/Api%20Services/charactersapi.dart';
import 'package:flutter_application/Data%20Layer/Repositories/charactersRepositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Helpers/Route/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Business Logic Layer/Characters/bloc/characters_bloc.dart';
import '../../Presentation Layer/Modules/characterdetails.dart';
import '../../Presentation Layer/Modules/layout.dart';
import '../../Presentation Layer/Modules/login.dart';

class AppRouting {
  late CharactersRepositories charactersRepositories;
  AppRouting() {
    charactersRepositories =
        CharactersRepositories(charactersApi: CharactersApi());
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersBloc(charactersRepositories),
            child: LoginPage(),
          ),
        );
      case layoutScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersBloc(charactersRepositories),
            child: LayoutScreen(),
          ),
        );

      case characterDetails:
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(),
        );
      default:
    }
  }
}
