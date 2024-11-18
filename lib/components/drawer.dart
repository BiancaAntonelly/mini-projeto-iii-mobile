import 'package:flutter/material.dart';
class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: const Text('Países'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_location),
            title: const Text('Adicionar Lugar'),
            onTap: () {
              Navigator.of(context).pushNamed('/adicionarLugar');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: const Text('Gerenciar Lugares'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/gerenciarLugares');
            },
          ),
          ListTile(
            leading: Icon(Icons.engineering),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/configuracoes');
            },
          ),
        ],
      ),
    );
  }
}
