import 'package:flutter/material.dart';
final juegos = ["juego1", "juego2", "juego3", "juego4"];

class Listview2 extends StatelessWidget{
  const Listview2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView2"),
      elevation: 10,),
      body: ListView.separated(itemBuilder: (context, index){return ListTile(title: Text(juegos[index]), trailing: Icon(Icons.ac_unit), onTap: (){print(juegos[index]);},);}, separatorBuilder: (context, index){return Divider();}, itemCount: juegos.length)
      );
  }

}