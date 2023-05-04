// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {}

class SearchingEvent extends CharactersEvent{
  String searchingText;
  SearchingEvent({required this.searchingText});
}

class ClearEvent extends CharactersEvent{
  bool stopSearching; 
  ClearEvent({required this.stopSearching});
}

class GetCharactersEvent extends CharactersEvent {
  bool isRefreshed;
  int page;
  bool stopSearching; 
  GetCharactersEvent({
    required this.isRefreshed,
    required this.page,
    required this.stopSearching
  });
}
class LoadingEvent extends CharactersEvent{
  List<CharactersModel> charactersModel;
  bool isRefreshed;
  int page;
  bool stopSearching; 

  LoadingEvent({required this.charactersModel,required this.isRefreshed,
    required this.page,required this.stopSearching});

}
class LoadedEvent extends CharactersEvent{
  List<CharactersModel> charactersModel;
  LoadedEvent({required this.charactersModel});
}
class LeadErrorEvent extends CharactersEvent{}
class LoginEvent extends CharactersEvent{}
