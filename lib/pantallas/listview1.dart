import 'package:flutter/material.dart';
final juegos1 = ["juego1", "juego2", "juego3", "juego4"];

class Listview1 extends StatelessWidget{
  const Listview1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView1"),
      elevation: 10,),
      body: ListView(
        children: [
          ...juegos1.map((e)=>ListTile(
            title: Text(e),
            trailing: Icon(Icons.access_time_filled_rounded),
          )),
          Divider()
        ],
        )
      );
  }

}