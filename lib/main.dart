import 'dart:convert';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/pokedetail.dart';
import 'package:pokeapp/pokemon.dart';

void main(){
  runApp(MaterialApp(
    theme: ThemeData.dark()
    ,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async{
    var res = await  http.get(url);

    var decodedValue = jsonDecode(res.body);

    pokeHub=PokeHub.fromJson(decodedValue);
    print(pokeHub);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PokeMon App"),
          centerTitle: true,
        ),

      body: pokeHub==null ?

          Center(child: CircularProgressIndicator()) :

      GridView.count(
          crossAxisCount: 2,

        children: pokeHub.pokemon.map((Pokemon poke) => Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) => PokeDetail(pokemon: poke,)
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: poke.img,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(poke.img))
                      ),
                    ),
                  ),

                  Text(poke.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
        )).toList(),
      ),


      floatingActionButton: FabCircularMenu(
        fabColor: Colors.tealAccent,
        fabOpenIcon: Icon(Icons.open_with,color: Colors.black,),
        fabCloseIcon: Icon(Icons.close,color: Colors.black,),
        children: <Widget>[
          Icon(Icons.android,color: Colors.black,),
          Icon(Icons.accessibility_new,color: Colors.black),
          Icon(Icons.accessibility,color: Colors.black),
          Icon(Icons.accessible,color: Colors.black),
          Icon(Icons.accessible_forward,color: Colors.black),
        ],
      ),
    );
  }
}
