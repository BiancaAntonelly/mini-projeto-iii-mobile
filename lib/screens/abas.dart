
import 'package:flutter/material.dart';
import 'package:mini_projeto_iii/screens/pais_screen.dart';
import 'package:provider/provider.dart';

import '../components/drawer.dart';
import '../model/lugar.dart';
import '../provider/FavoritosProvider.dart';
import 'favoritos.dart';

class MinhasAbas extends StatefulWidget {
  final List<Lugar> listaFavoritos;
  const MinhasAbas({super.key, required this.listaFavoritos});

  @override
  State<MinhasAbas> createState() => _MinhasAbasState();
}

class _MinhasAbasState extends State<MinhasAbas> {



  @override
  Widget build(BuildContext context) {
    return MinhasAbasBottom();
  }
}

/* class MinhasAbasTop extends StatelessWidget {
  final List<Lugar> lugaresFavoritos;
  MinhasAbasTop({
    super.key,
    required this.lugaresFavoritos,
  });

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: MeuDrawer(),
          appBar: AppBar(
            backgroundColor: ThemeData().primaryColor,
            bottom: const TabBar(
                indicatorColor: Colors.amber,
                labelColor: Colors.amber,
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.category,
                    ),
                    text: "Países",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.star,
                    ),
                    text: "Favoritos",
                  )
                ]),
          ),
          body: const TabBarView(
            children: [
              PaisScreen(),
              FavoritosScreen(lugaresFavoritos: lugaresFavoritos,),
            ],
          ),
        ));
  }
} */
class MinhasAbasBottom extends StatefulWidget {
  const MinhasAbasBottom({super.key});

  @override
  State<MinhasAbasBottom> createState() => _MinhasAbasBottomState();
}

class _MinhasAbasBottomState extends State<MinhasAbasBottom> {
  String _nomeTab = "Países";
  List<String> _nomeTabs = ["Países", "Favoritos"];

  void _getNomeTab(int index) {
    setState(() {
      _nomeTab = _nomeTabs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "${_nomeTab.toString()}",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: ThemeData().primaryColor,
            ),
            drawer: MeuDrawer(),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    children: [
                      PaisScreen(),
                      Consumer<FavoritosProvider>(
                        builder: (context, favoritosProvider, child) {
                          return FavoritosScreen(
                            lugaresFavoritos: favoritosProvider.lugaresFavoritos,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  decoration: BoxDecoration(
                    color: ThemeData().primaryColor,
                  ),
                  child: TabBar(
                      onTap: (index) {
                        _getNomeTab(index);
                      },
                      indicatorColor: Colors.amber,
                      labelColor: Colors.amber,
                      unselectedLabelColor: Colors.white60,
                      tabs: const [
                        Tab(
                          icon: Icon(
                            Icons.category,
                          ),
                          text: "Países",
                        ),
                        Tab(
                          icon: Icon(
                            Icons.star,
                          ),
                          text: "Favoritos",
                        )
                      ]),
                )
              ],
            )));
  }
}
