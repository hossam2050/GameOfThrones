part of 'characters_bloc.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {
  final bool isFirstFetch;
  final CharacterCollection characterCollection;
  CharactersLoading({required this.characterCollection ,this.isFirstFetch = false });
}

class CharactersLoaded extends CharactersState {
  final CharacterCollection characterCollection;
  CharactersLoaded({required this.characterCollection});
}

class CharactersError extends CharactersState {
  final CharacterCollection characterCollection;
  CharactersError({required this.characterCollection});
}
