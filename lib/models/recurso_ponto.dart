class RecursoPonto {
  RecursoPonto({
    required this.id,
    required this.pontoId,
    required this.tipo,
    required this.disponivel,
  }) : atualizadoEm = DateTime(2026, 11, 9, 9);

  int id;
  int pontoId;
  String tipo;
  bool disponivel;
  DateTime atualizadoEm;

  String get nome {
    const nomes = {
      'AGUA': 'Água',
      'SOMBRA': 'Sombra',
      'ASSENTO': 'Assentos',
      'ACESSIBILIDADE': 'Acessibilidade',
    };
    return nomes[tipo] ?? tipo;
  }
}
