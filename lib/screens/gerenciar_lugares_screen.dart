import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/lugar.dart';
import '../provider/FavoritosProvider.dart';

class GerenciarLugaresScreen extends StatelessWidget {
  const GerenciarLugaresScreen({super.key});

  void _editarLugar(BuildContext context, Lugar lugar) {
    showDialog(
      context: context,
      builder: (ctx) {
        final _tituloController = TextEditingController(text: lugar.titulo);
        final _avaliacaoController = TextEditingController(
            text: lugar.avaliacao.toString());
        final _custoMedioController =
            TextEditingController(text: lugar.custoMedio.toString());

        return AlertDialog(
          title: Text('Editar Lugar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _avaliacaoController,
                decoration: InputDecoration(labelText: 'Avaliação (0 a 5)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _custoMedioController,
                decoration: InputDecoration(labelText: 'Custo Médio'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final novosDados = Lugar(
                  id: lugar.id,
                  titulo: _tituloController.text,
                  paises: lugar.paises,
                  imagemUrl: lugar.imagemUrl,
                  recomendacoes: lugar.recomendacoes,
                  avaliacao:
                      double.tryParse(_avaliacaoController.text) ?? lugar.avaliacao,
                  custoMedio:
                      double.tryParse(_custoMedioController.text) ?? lugar.custoMedio,
                );

                Provider.of<FavoritosProvider>(context, listen: false)
                    .atualizarLugar(lugar.id, novosDados);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lugar "${novosDados.titulo}" atualizado com sucesso!'),
                  ),
                );
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lugares = Provider.of<FavoritosProvider>(context).lugares;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lugares'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: lugares.length,
        itemBuilder: (ctx, index) {
          final lugar = lugares[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(lugar.imagemUrl),
            ),
            title: Text(lugar.titulo),
            subtitle: Text('Avaliação: ${lugar.avaliacao} | Custo: R\$${lugar.custoMedio}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editarLugar(context, lugar),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Confirmação'),
                        content: Text('Deseja remover o lugar "${lugar.titulo}"?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<FavoritosProvider>(context, listen: false)
                                  .removerLugar(lugar.id);
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Lugar "${lugar.titulo}" removido!'),
                                ),
                              );
                            },
                            child: Text('Confirmar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
