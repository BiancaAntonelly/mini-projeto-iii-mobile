import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/lugar.dart';
import '../provider/FavoritosProvider.dart';

class DetalhesLugarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lugar = ModalRoute.of(context)?.settings.arguments as Lugar;
    final favoritosProvider = Provider.of<FavoritosProvider>(context);
    final bool isFavorito = favoritosProvider.isFavorito(lugar);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          lugar.titulo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              lugar.imagemUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dicas',
              style: ThemeData().textTheme.displayLarge,
            ),
          ),
          Container(
            width: 350,
            height: 300,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: lugar.recomendacoes.length,
              itemBuilder: (contexto, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(lugar.recomendacoes[index]),
                      subtitle: Text(lugar.titulo),
                      onTap: () {
                        print(lugar.recomendacoes[index]);
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          favoritosProvider.toggleFavorito(lugar);
        },
        child: Icon(
          isFavorito ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
