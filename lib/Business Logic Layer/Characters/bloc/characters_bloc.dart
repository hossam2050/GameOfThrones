import 'package:bloc/bloc.dart';
import 'package:flutter_application/Data%20Layer/Models/Characters/charactercollection.dart';
import 'package:flutter_application/Data%20Layer/Models/Characters/characters.dart';
import 'package:flutter_application/Data%20Layer/Repositories/charactersRepositories.dart';
import 'package:meta/meta.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepositories charactersRepositories;
  CharactersBloc(this.charactersRepositories) : super(CharactersInitial()) {
    on<CharactersEvent>((event, emit)async{
       if(event is GetCharactersEvent){
        var characters = await charactersRepositories.getCharacters();
        add(LoadingEvent(charactersModel: characters, 
        page: event.page, isRefreshed:event.isRefreshed,
        stopSearching: event.stopSearching));
       }
       else if(event is LoadingEvent){
        if(state is CharactersLoading) return;
        final currentState = state;
        CharacterCollection characterCollection = 
        CharacterCollection(character: [], error: '');
        if(currentState is CharactersLoaded){
        if(event.page == 1 && event.isRefreshed){
        characterCollection = CharacterCollection(character:[], error: '');
        add(GetCharactersEvent(isRefreshed: true, page: 1, stopSearching: false));
        return;
         }
        else if(event.stopSearching){
          characterCollection.character!.clear();
        characterCollection.character!.addAll(event.charactersModel);
        }
        else{
        characterCollection = currentState.characterCollection;
        characterCollection.character!.addAll(event.charactersModel);
        } 
       }
       else{
        characterCollection.character!.addAll(event.charactersModel);
       }
         add(LoadedEvent(charactersModel: characterCollection.character!));
         emit(CharactersLoading(characterCollection: characterCollection,isFirstFetch: event.page == 1));
       }
       else if(event is LoadedEvent){
        if(event.charactersModel.isEmpty){
          add(LeadErrorEvent());
        }
        else{
          emit(CharactersLoaded(characterCollection: CharacterCollection(error: '',
         character: event.charactersModel)));
        }
       }
       else if(event is LoginEvent){
        CharacterCollection characters = CharacterCollection();
        emit(CharactersLoaded(characterCollection: characters));
       }

       else if(event is SearchingEvent){
        var characters = (state as CharactersLoaded).characterCollection.character!;
        var filterredCharacters = characters.
        where((element) => element.fullName!.toLowerCase().
        contains(event.searchingText.toLowerCase())).toList();
        emit(CharactersLoaded(characterCollection:
         CharacterCollection(character: filterredCharacters,error: '')));
       }
       else if(event is ClearEvent){
        add(GetCharactersEvent(isRefreshed: false, page:1, stopSearching: true));
       }
    });
  }

   /*getCharacters(bool isRefreshed, int page){
     if(state is CharactersLoading) return;
     final currentState = state;
     CharacterCollection characterCollection = 
     CharacterCollection(character: [], error: '');
     if(currentState is CharactersLoaded){
      if(page == 1 && isRefreshed){
        characterCollection = CharacterCollection(character: [], error: '');
      }
      else{
        characterCollection = currentState.characterCollection;
      } 
     }
     emit(CharactersLoading(characterCollection: characterCollection,isFirstFetch: page == 1));
      charactersRepositories.getCharacters().then((characterss){
       if(characterss.isEmpty){
        characterCollection.error = "Data is Not Loaded";
        emit(CharactersError(characterCollection: characterCollection));
       }
       else{
        final characters = (state as CharactersLoading).characterCollection;
        characters.character!.addAll(characterss);
        emit(CharactersLoaded(characterCollection: characters));
       }
      });
   }*/
}
