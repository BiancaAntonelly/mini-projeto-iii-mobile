
import 'package:flutter/material.dart';

import '../components/item_pais.dart';
import '../data/dados.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});


  List<Widget> getPaises() {
    return paises.map((pais) => ItemPais(pais: pais)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Países",
          style: TextStyle(color: Colors.white),
        ),
      ), */
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 120,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          
        ),
        children: getPaises(),
      ),
    );
  }
}
