import 'package:dio/dio.dart';
import 'package:flutter_application/Data%20Layer/Models/Characters/characters.dart';
import 'package:flutter_application/Helpers/Components/dio_config.dart';
import 'package:flutter_application/Helpers/Server/endpoints.dart';

class CharactersApi {
  late Dio dio;

  CharactersApi(){
    dio = DioConfiguration.dio;
  }

  Future<List<dynamic>> getCharacters()async{
    try {
      var response =await dio.get(charactersUrl);
       return response.data;
    }
    on DioError catch (e) {
      print(e.message);
      return [];
    }
  }
}