import 'package:desafio_pokemon/Connections/pokemon_helper.dart';
import 'package:desafio_pokemon/ui/pokemon_page.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
const request = "https://pokeapi.co/api/v2/pokemon/";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String pokemon;
  TextEditingController nomePokemon = TextEditingController();
  PokemonHelper pokemonHelper = PokemonHelper();

  void Search(){
    String _nomePokemon;
    setState(() {
      _nomePokemon = nomePokemon.text;
      pokemonHelper.searchedPokemon  = _nomePokemon;
      Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonPage(_nomePokemon.toLowerCase())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Ache seu Pokemon"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: nomePokemon,
                    decoration: InputDecoration(
                      labelText: "Digite o nome do pokemon, ex: pikachu",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      )
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
                child: RaisedButton(
                  child: Text("Procurar Pokemon", style: TextStyle(color: Colors.white, fontSize: 20)),
                  color: Colors.red,
                  onPressed: (){
                    Search();
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}