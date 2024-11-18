import 'package:flutter/material.dart';
import '../model/lugar.dart';

class FavoritosProvider with ChangeNotifier {
  final List<Lugar> _lugaresFavoritos = [];

  List<Lugar> get lugaresFavoritos => List.unmodifiable(_lugaresFavoritos);

  void toggleFavorito(Lugar lugar) {
    if (_lugaresFavoritos.contains(lugar)) {
      _lugaresFavoritos.remove(lugar);
    } else {
      _lugaresFavoritos.add(lugar);
    }
    notifyListeners();
  }

  bool isFavorito(Lugar lugar) => _lugaresFavoritos.contains(lugar);

  final List<Lugar> _lugares = [];

  List<Lugar> get lugares => List.unmodifiable(_lugares);

  void adicionarLugar(Lugar lugar) {
    _lugares.add(lugar);
    notifyListeners();
  }

  void removerLugar(String id) {
    _lugares.removeWhere((lugar) => lugar.id == id);
    notifyListeners();
  }

  void atualizarLugar(String id, Lugar lugarAtualizado) {
    final index = _lugares.indexWhere((lugar) => lugar.id == id);
    if (index != -1) {
      _lugares[index] = lugarAtualizado;
      notifyListeners();
    }
  }

  List<Lugar> getLugaresPorPais(String paisId) {
    return _lugares.where((lugar) => lugar.paises.contains(paisId)).toList();
  }
}
