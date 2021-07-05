import 'package:desafio_pokemon/Connections/api_connection.dart';
import 'package:desafio_pokemon/Connections/pokemon_helper.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';




import 'dart:convert';
const request = "https://pokeapi.co/api/v2/pokemon/";

class PokemonPage extends StatefulWidget {

  String searchedPokemon;
  PokemonPage(this.searchedPokemon);

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  
  APIConnection apiConnection = APIConnection();
  String pokemonName, pokemonType;

  PokemonHelper pokemon = PokemonHelper();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchedPokemon),
        backgroundColor: Colors.red,
      ),
      /*
      body: Center(
        child: Text("O nome do pokemon é: ${widget.nomePokemon}"),
      ),
      */

      body: FutureBuilder<Map> (
        future: apiConnection.getData(widget.searchedPokemon),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text("Procurando Pokemon...",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25.0),
                    textAlign: TextAlign.center,)
              );
            default:
              if(snapshot.hasError){
                return Center(
                    child: Text("Esse pokemon não existe, coloque um nome válido",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25.0),
                      textAlign: TextAlign.center,)
                );
              } else{

                getPokemon(snapshot);

                return SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(60.0,60.0,60.0,10.0),
                            child: Column(
                              children: <Widget>[
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(40.0),
                                    child: Center(
                                      child: Image.network(pokemon.sprites,
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.red, width: 10),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40.0,5.0,40.0,5.0),
                                    child: Center(
                                      child: Text("Nome: ${pokemon.name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40.0,5.0,40.0,5.0),
                                    child: Center(
                                      child: Text("Habilidade: ${pokemon.abilities}",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40.0,5.0,40.0,5.0),
                                    child: Center(
                                      child: Text("Altura: ${pokemon.height}'",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40.0,5.0,40.0,5.0),
                                    child: Center(
                                      child: Text("Posição: ${pokemon.id}",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40.0,5.0,40.0,5.0),
                                    child: Center(
                                      child: Text("Peso: ${pokemon.weight} kg",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }

  getPokemon(snapshot){
    pokemon.name = snapshot.data["name"];
    pokemon.type = snapshot.data["types"][0]["type"]["name"];
    pokemon.abilities = snapshot.data["abilities"][0]["ability"]["name"];
    pokemon.height = snapshot.data["height"];
    pokemon.id = snapshot.data["id"];
    pokemon.sprites = snapshot.data["sprites"]["front_default"];
    pokemon.weight = snapshot.data["weight"];
  }

}
