class FavoritoRepository {
  final List<String> codigosFavoritos = [];

  bool estaFavorito(String codigo) => codigosFavoritos.contains(codigo);

  void alternarFavorito(String codigo) {
    if (estaFavorito(codigo)) {
      codigosFavoritos.remove(codigo);
    } else {
      codigosFavoritos.add(codigo);
    }
  }
}
