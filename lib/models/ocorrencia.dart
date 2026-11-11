class Ocorrencia {
  Ocorrencia({
    required this.id,
    required this.pontoId,
    required this.usuarioId,
    required this.categoria,
    required this.descricao,
    required this.prioridade,
    required this.status,
    required this.abertaEm,
    this.resolvidaEm,
  });

  static const categorias = {
    'SEM_AGUA': 'Sem água',
    'SEM_SOMBRA': 'Sem sombra',
    'ACESSO_BLOQUEADO': 'Acesso bloqueado',
    'OUTRO': 'Outro problema',
  };

  int id;
  int pontoId;
  int usuarioId;
  String categoria;
  String descricao;
  String prioridade;
  String status;
  DateTime abertaEm;
  DateTime? resolvidaEm;

  String get nomeCategoria => categorias[categoria] ?? categoria;

  String get nomeStatus {
    const nomes = {
      'ABERTA': 'Aberto',
      'EM_ANALISE': 'Em análise',
      'RESOLVIDA': 'Resolvido',
    };
    return nomes[status] ?? status;
  }

  String get nomePrioridade {
    const nomes = {'ALTA': 'Alta', 'MEDIA': 'Média', 'BAIXA': 'Baixa'};
    return nomes[prioridade] ?? prioridade;
  }
}
