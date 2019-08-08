import 'package:flutter/material.dart';
import 'package:pokedexcim/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetay extends StatefulWidget {
  Pokemon gelenPokemon;
  PokemonDetay({this.gelenPokemon});

  @override
  _PokemonDetayState createState() => _PokemonDetayState();
}

class _PokemonDetayState extends State<PokemonDetay> {

  PaletteGenerator paletteGenerator;
  Color baskinRenk = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // baskinRengiBul();
    mertinYontemi();
  }

  void mertinYontemi(){

     PaletteGenerator.fromImageProvider(NetworkImage(widget.gelenPokemon.img)).then((deger) {
       setState(() {
         baskinRenk = deger.vibrantColor.color;
     } );
    });

  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
    PaletteGenerator.fromImageProvider(NetworkImage(widget.gelenPokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(widget.gelenPokemon.name),
      ),
      body: OrientationBuilder(builder: (context, yon) {
        if (Orientation.portrait == yon) {
          return DikeyEkran(context);
        } else {
          return YatayEkran(context);
        }
      }),
    );
  }

  Stack DikeyEkran(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            width: MediaQuery.of(context).size.width * 0.95,
            top: MediaQuery.of(context).size.height * 0.1,
            left: 10,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      widget.gelenPokemon.name,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          widget.gelenPokemon.height,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 21),
                        ),
                        Text(
                          widget.gelenPokemon.weight,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 21),
                        ),
                      ],
                    ),
                    Text(
                      "Pokemonun Tipleri",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.gelenPokemon.type
                          .map((tipler) => Chip(label: Text(tipler)))
                          .toList(),
                    ),
                    Text(
                      "Önceki Evrimleri",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.gelenPokemon.prevEvolution != null
                            ? widget.gelenPokemon.prevEvolution
                                .map((onceki) => Chip(label: Text(onceki.name)))
                                .toList()
                            : [Text("Daha bebek la")]),
                    Text(
                      "Sonraki Evrimleri",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.gelenPokemon.nextEvolution != null
                            ? widget.gelenPokemon.nextEvolution
                                .map((gelisim) =>
                                    Chip(label: Text(gelisim.name)))
                                .toList()
                            : [Text("Son Evrimde")]),
                    Text(
                      "Zayıflıklar",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.gelenPokemon.weaknesses != null
                            ? widget.gelenPokemon.weaknesses
                                .map((weaknesses) =>
                                    Chip(label: Text(weaknesses)))
                                .toList()
                            : [Text("Hasar yemez")]),
                  ],
                ))),
        Align(
          child: Hero(
              tag: widget.gelenPokemon.name,
              child: Image.network(
                widget.gelenPokemon.img,
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.width / 2.5,
                fit: BoxFit.fill,
              )),
          alignment: Alignment.topCenter,
        )
      ],
    );
  }

  Widget YatayEkran(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Row(children: <Widget>[
        Hero(
            tag: widget.gelenPokemon.name,
            child: Image.network(
              widget.gelenPokemon.img,
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.width / 2.5,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Text(
                  widget.gelenPokemon.name,
                  style:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      widget.gelenPokemon.height,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 21),
                    ),
                    Text(
                      widget.gelenPokemon.weight,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 21),
                    ),
                  ],
                ),
                Text(
                  "Pokemonun Tipleri",
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.gelenPokemon.type
                      .map((tipler) => Chip(label: Text(tipler)))
                      .toList(),
                ),
                Text(
                  "Önceki Evrimleri",
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.gelenPokemon.prevEvolution != null
                        ? widget.gelenPokemon.prevEvolution
                        .map((onceki) => Chip(label: Text(onceki.name)))
                        .toList()
                        : [Text("Daha bebek la")]),
                Text(
                  "Sonraki Evrimleri",
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.gelenPokemon.nextEvolution != null
                        ? widget.gelenPokemon.nextEvolution
                        .map((gelisim) =>
                        Chip(label: Text(gelisim.name)))
                        .toList()
                        : [Text("Son Evrimde")]),
                Text(
                  "Zayıflıklar",
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.gelenPokemon.weaknesses != null
                        ? widget.gelenPokemon.weaknesses
                        .map((weaknesses) =>
                        Chip(label: Text(weaknesses)))
                        .toList()
                        : [Text("Hasar yemez")]),
              ],
            ),
          ),
        )
      ],),
    );
  }
}
