import 'package:refugio/models/ocorrencia.dart';

class OcorrenciaRepository {
  OcorrenciaRepository() {
    final categorias = [
      'SEM_AGUA',
      'SEM_SOMBRA',
      'ACESSO_BLOQUEADO',
      'OUTRO',
      'SEM_AGUA',
      'SEM_SOMBRA',
      'OUTRO',
      'ACESSO_BLOQUEADO',
      'SEM_AGUA',
      'OUTRO',
    ];
    final status = [
      'ABERTA',
      'EM_ANALISE',
      'ABERTA',
      'RESOLVIDA',
      'EM_ANALISE',
      'ABERTA',
      'ABERTA',
      'EM_ANALISE',
      'RESOLVIDA',
      'ABERTA',
    ];
    final usuarios = [1, 2, 3, 4, 5, 6, 7, 8, 1, 2];
    final descricoes = [
      'Bebedouro não está funcionando',
      'Área de sombra temporariamente bloqueada',
      'Rampa de acesso está obstruída',
      'Sinalização do espaço ilegível',
      'Ponto sem reposição de água',
      'Cobertura da área não está disponível',
      'Horário informado parece incorreto',
      'Entrada principal do espaço está fechada',
      'Bebedouro estava sem água',
      'Local está sinalizado como indisponível',
    ];

    for (int i = 0; i < categorias.length; i++) {
      ocorrencias.add(
        Ocorrencia(
          id: i + 1,
          pontoId: i + 1,
          usuarioId: usuarios[i],
          categoria: categorias[i],
          descricao: descricoes[i],
          prioridade: calcularPrioridade(categorias[i]),
          status: status[i],
          abertaEm: DateTime(2026, 11, 9, 11, i + 1),
          resolvidaEm: status[i] == 'RESOLVIDA'
              ? DateTime(2026, 11, 9, 14, i + 1)
              : null,
        ),
      );
    }
  }

  final int usuarioDemonstracaoId = 1;
  final List<Ocorrencia> ocorrencias = [];

  String calcularPrioridade(String categoria) {
    if (categoria == 'ACESSO_BLOQUEADO') return 'ALTA';
    if (categoria == 'SEM_AGUA' || categoria == 'SEM_SOMBRA') return 'MEDIA';
    return 'BAIXA';
  }

  List<Ocorrencia> buscarMeusRelatos() {
    final List<Ocorrencia> resultado = [];
    for (final ocorrencia in ocorrencias.reversed) {
      if (ocorrencia.usuarioId == usuarioDemonstracaoId) {
        resultado.add(ocorrencia);
      }
    }
    return resultado;
  }

  void adicionarRelato({
    required int pontoId,
    required String categoria,
    required String descricao,
  }) {
    ocorrencias.add(
      Ocorrencia(
        id: ocorrencias.length + 1,
        pontoId: pontoId,
        usuarioId: usuarioDemonstracaoId,
        categoria: categoria,
        descricao: descricao.trim(),
        prioridade: calcularPrioridade(categoria),
        status: 'ABERTA',
        abertaEm: DateTime.now(),
      ),
    );
  }
}
