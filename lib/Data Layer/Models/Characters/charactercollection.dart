import 'package:flutter_application/Data%20Layer/Models/Characters/characters.dart';

class CharacterCollection {
  String error;
  List<CharactersModel>? character;

  CharacterCollection({this.error = "", this.character});
}