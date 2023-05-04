import 'package:flutter/material.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Characters/bloc/characters_bloc.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Languages/bloc/app_language_bloc.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Theme/bloc/app_theme_bloc.dart';
import 'package:flutter_application/Data%20Layer/Models/Characters/charactercollection.dart';
import 'package:flutter_application/Helpers/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/Layout Widgets/blocwidget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
CharacterCollection characterCollection = 
CharacterCollection(error: '', character: []);
ScrollController charactersController = ScrollController();
bool isSearching = false;
TextEditingController searchController = TextEditingController();

scrollController(){
  try {
    if(charactersController.position.atEdge){
      if(charactersController.position.pixels != 0){
        pageNo++;
      }
    }
    
  } catch (e) {
    
  }
}

int pageNo = 1;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersBloc>(context).add(GetCharactersEvent(isRefreshed:false, page:1, stopSearching: false));
    charactersController.addListener(scrollController);
  }

  @override
  void dispose() {
    super.dispose();
    charactersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.orange,
    actions: isSearching?
    [
      IconButton(
      icon: Icon(Icons.close),
      onPressed: (){
        setState(() {
         isSearching = false;
         searchController.clear();
        });
        BlocProvider.of<CharactersBloc>(context).add(ClearEvent(stopSearching: true));
      },
     ),
    ]:[
     IconButton(
      icon: theme == "l"?
      Icon(Icons.sunny) : Icon(Icons.power),
      onPressed: (){
        setState(() {
          if(theme == "l"){
            BlocProvider.of<AppThemeBloc>(context).add(DarkThemeEvent());
          }
          else{
            BlocProvider.of<AppThemeBloc>(context).add(LightThemeEvent());
          }
        });
      },
     ), 
     TextButton(onPressed: (){
      setState(() {
          if(selectedLang == "en"){
            BlocProvider.of<AppLanguageBloc>(context).add(ArabicLanguageEvent());
          }
          else{
            BlocProvider.of<AppLanguageBloc>(context).add(EnglishLanguageEvent());
          }
        });
     }, child: Text(selectedLang == "en"?
     "العربية" : "English ", 
     style: TextStyle(
      color: Colors.white, fontSize:12 ),)),
     IconButton(
      icon: Icon(Icons.search, color: Colors.white,),
      onPressed: (){
        setState(() {
          isSearching = true;
        });
      },
     ),
    ],
    automaticallyImplyLeading: false,
    title:isSearching?
    TextField(
    style: TextStyle(
    color: Colors.white
    ),
    decoration: InputDecoration(
     hintText: "Search For A character",
     hintStyle: TextStyle(color: Colors.white),
     border: InputBorder.none,
    ),
    onChanged: (String value){
      BlocProvider.of<CharactersBloc>(context).add(SearchingEvent(searchingText: value));
    },
    ):Text("Game Of Thrones",
     style: TextStyle(color: Colors.white, fontSize: 13),),
    ),
    body: buildLayoutBloc(characterCollection,charactersController)
    );
  }
}