import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/dados.dart';
import '../model/lugar.dart';
import '../model/pais.dart';
import '../provider/FavoritosProvider.dart';

class AdicionarLugarScreen extends StatefulWidget {
  const AdicionarLugarScreen({super.key});

  @override
  State<AdicionarLugarScreen> createState() => _AdicionarLugarScreenState();
}

class _AdicionarLugarScreenState extends State<AdicionarLugarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _paisController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _avaliacaoController = TextEditingController();
  final _custoMedioController = TextEditingController();

  void _salvarLugar() {
    if (_formKey.currentState!.validate()) {
      final titulo = _tituloController.text;
      final paisNome = _paisController.text;

      // Encontrar o país correspondente
      final pais = paises.firstWhere(
            (p) => p.titulo.toLowerCase() == paisNome.toLowerCase(),
        orElse: () => Pais(
          id: 'default',
          titulo: 'País Desconhecido',
          cor: Colors.grey,
        ),
      );

      if (pais.id == 'default') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('País "$paisNome" não encontrado!'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Coletar os dados adicionais
      final avaliacao = double.tryParse(_avaliacaoController.text) ?? 0.0;
      final custoMedio = double.tryParse(_custoMedioController.text) ?? 0.0;

      // Criar o novo lugar
      final novoLugar = Lugar(
        id: UniqueKey().toString(),
        titulo: titulo,
        paises: [pais.id],
        imagemUrl: 'https://s2.glbimg.com/Qgl26Ze8x7iJ1HoFwwRkwfjgGrM=/smart/e.glbimg.com/og/ed/f/original/2020/11/05/brasil-tem-duas-praias-entre-as-cinco-melhores-do-mundo.jpg',
        recomendacoes: [_descricaoController.text],
        avaliacao: avaliacao,
        custoMedio: custoMedio,
      );

      // Adicionar o novo lugar ao provider de favoritos
      Provider.of<FavoritosProvider>(context, listen: false)
          .adicionarLugar(novoLugar);

      // Exibir o Snackbar e redirecionar para a tela inicial
      Navigator.of(context).pushReplacementNamed('/');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lugar "$titulo" adicionado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Lugar'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _paisController,
                decoration: InputDecoration(labelText: 'País'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o país.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _avaliacaoController,
                decoration: InputDecoration(labelText: 'Avaliação (0 a 5)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma avaliação.';
                  }
                  final valor = double.tryParse(value);
                  if (valor == null || valor < 0 || valor > 5) {
                    return 'Insira um valor entre 0 e 5.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _custoMedioController,
                decoration: InputDecoration(labelText: 'Custo Médio'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o custo médio.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Insira um valor numérico válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarLugar,
                child: Text('Salvar Lugar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
