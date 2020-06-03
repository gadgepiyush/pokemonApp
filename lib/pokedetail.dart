import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text(pokemon.name),
        elevation: 0,
        backgroundColor: Colors.tealAccent,
      ),

    backgroundColor: Colors.tealAccent,

      body: Stack(
        children: <Widget>[
          Positioned(
              height: MediaQuery.of(context).size.height*0.75,
            width: MediaQuery.of(context).size.width-20,
            left: 10,
            top: MediaQuery.of(context).size.height*0.1,

            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),

                  Text(pokemon.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

                  Text("Height: ${pokemon.height}"),
                  Text("Weight: ${pokemon.weight}"),

                Text("Powers"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type.map((e) =>
                        FilterChip(
                      label: Text(e),
                          backgroundColor: Colors.yellow,
                          onSelected: (e){},
                    )).toList(),
                  ),

                  Text("Weaknesses"),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses.map((e) =>
                        FilterChip(
                          label: Text(e,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.deepPurple,
                          onSelected: (e){},
                        )
                    ).toList(),
                  )
                ],
              ),
            ),
          ),


          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(pokemon.img),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
