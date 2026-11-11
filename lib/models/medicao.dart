class Medicao {
  Medicao({
    required this.id,
    required this.pontoId,
    required this.temperaturaC,
    required this.umidadePct,
    required this.origem,
    required this.medidaEm,
  });

  int id;
  int pontoId;
  double temperaturaC;
  double umidadePct;
  String origem;
  DateTime medidaEm;

  String get classificacao {
    if (temperaturaC >= 32) return 'ATENCAO_DIDATICA';
    return 'INFORMATIVO';
  }
}
