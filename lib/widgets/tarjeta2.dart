import 'package:flutter/material.dart';

class Tarjeta2 extends StatelessWidget{

  final String imgUrl;
  final String? texto;

  const Tarjeta2({super.key, required this.imgUrl, this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          /*Image(
            image: NetworkImage("https://google.com")
            )*/
          FadeInImage(
            placeholder: AssetImage("../assets/uri.png"), 
            image: NetworkImage(imgUrl),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            ),
          if (texto != null)
            Container(
              alignment: AlignmentGeometry.centerRight,
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              child: Text(texto ?? "no hay pie de imagen"),
            )
        ],
      ),
    );
  }
}