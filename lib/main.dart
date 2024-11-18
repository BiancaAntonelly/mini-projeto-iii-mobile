import 'package:flutter/material.dart';
import 'package:mini_projeto_iii/provider/FavoritosProvider.dart';
import 'package:mini_projeto_iii/screens/abas.dart';
import 'package:mini_projeto_iii/screens/adicionar_lugar_screen.dart';
import 'package:mini_projeto_iii/screens/configuracoes.dart';
import 'package:mini_projeto_iii/screens/detalhes_lugar.dart';
import 'package:mini_projeto_iii/screens/gerenciar_lugares_screen.dart';
import 'package:mini_projeto_iii/screens/lugares_por_pais.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
      ],
      child: MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => MinhasAbas(listaFavoritos: [],),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => DetalhesLugarScreen(),
        '/configuracoes': (ctx) => ConfigracoesScreen(),
        '/adicionarLugar': (ctx) => AdicionarLugarScreen(),
        '/gerenciarLugares': (ctx) => GerenciarLugaresScreen(),
      },
    );
  }
}
