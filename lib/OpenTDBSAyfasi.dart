import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/openTDB.dart';

class Sorular extends StatefulWidget {
  @override
  _SorularState createState() => _SorularState();
}

class _SorularState extends State<Sorular> {
  String veriAdresi =
      "https://opentdb.com/api.php?amount=10";

  Future<OpenTdb> pokemonlariGetir() async {
    var cevap = await http.get(veriAdresi);
    var cozumlenmisJson = json.decode(cevap.body);

    return OpenTdb.fromJson(cozumlenmisJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OenTDB uygulaması"),
      ),
      body: FutureBuilder(
          future: pokemonlariGetir(),
          builder: (context, AsyncSnapshot<OpenTdb> gelenSorular) {
            if (gelenSorular.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (gelenSorular.connectionState == ConnectionState.done) {


              /*return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Text(gelenPokedex.data.pokemon[index].name);
                  });

                  Alternatif

                  */

              return GridView.count(crossAxisCount: 2, children:
              gelenSorular.data.results.map((herBirPokemon) {
                return Text(herBirPokemon.question);
              }).toList()
                ,);
            } else {
              return null;
            }
          }),
    );
  }
}
