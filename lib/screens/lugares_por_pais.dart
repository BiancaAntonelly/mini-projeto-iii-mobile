
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/item_lugar.dart';
import '../data/dados.dart';
import '../model/lugar.dart';
import '../model/pais.dart';
import '../provider/FavoritosProvider.dart';
class LugarPorPaisScreen extends StatelessWidget {
  LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pais = ModalRoute.of(context)?.settings.arguments as Pais;

    // Obter lugares do Provider
    final lugaresPorPais = Provider.of<FavoritosProvider>(context)
        .getLugaresPorPais(pais.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pais.cor,
        title: Text(
          "Lugares em ${pais.titulo}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: lugaresPorPais.length,
        itemBuilder: (context, index) {
          return ItemLugar(lugar: lugaresPorPais[index]);
        },
      ),
    );
  }
}
