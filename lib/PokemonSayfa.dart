import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexcim/pokemonDetay.dart';
import 'dart:convert';

import 'model/pokedex.dart';

class PokemonSayfasi extends StatefulWidget {
  @override
  _PokemonSayfasiState createState() => _PokemonSayfasiState();
}

class _PokemonSayfasiState extends State<PokemonSayfasi> {
  Pokedex pokedexler;
  String veriAdresi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var cevap = await http.get(veriAdresi);
    var cozumlenmisJson = json.decode(cevap.body);

    pokedexler = Pokedex.fromJson(cozumlenmisJson);
    return pokedexler;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex uygulaması"),
      ),
      body: FutureBuilder(
          future: veri,
          builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
            if (gelenPokedex.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (gelenPokedex.connectionState == ConnectionState.done) {
              /*return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Text(gelenPokedex.data.pokemon[index].name);
                  });

                  Alternatif
                  */

              return GridView.count(
                crossAxisCount: 2,
                children: gelenPokedex.data.pokemon.map((herBirPokemon) {
                  return InkWell(
                    child: Hero(
                      tag: herBirPokemon.name,
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: FadeInImage.assetNetwork(
                                placeholder: "dosyalar/yukleniyor.gif",
                                image: herBirPokemon.img,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              herBirPokemon.name,
                              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PokemonDetay(
                                gelenPokemon: herBirPokemon,
                              )));
                    },
                  );
                }).toList(),
              );
            } else {
              return null;
            }
          }),
    );
  }
}
