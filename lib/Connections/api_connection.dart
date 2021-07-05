import 'package:desafio_pokemon/Connections/pokemon_helper.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';
const request = "https://pokeapi.co/api/v2/pokemon/";

class APIConnection{

  PokemonHelper pokemon;

  Future<Map> getData(String nomePokemon) async{
    http.Response response = await http.get(request+nomePokemon);
    return json.decode(response.body);
  }

}




