import 'package:flutter/material.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Characters/bloc/characters_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data Layer/Models/Characters/charactercollection.dart';
import '../Custom/loadingwidget.dart';
import 'charcterslistwidget.dart';

Widget buildLayoutBloc(CharacterCollection charatcterCollection,
 ScrollController characterController){
 return BlocBuilder<CharactersBloc,CharactersState>(
   builder: (context, state) {
    if(state is CharactersLoaded){
     charatcterCollection = state.characterCollection;
     return CharactersListWidget(characterCollection: charatcterCollection,
     characterController: characterController,);
    }
    else if(state is CharactersLoading){
      return LoadingWidget();
    }
    else if(state is CharactersError){
      return Text("Error Happen For Retrieving Data");
    }
     return Container();
   },
 );
}

