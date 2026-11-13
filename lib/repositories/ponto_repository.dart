import 'package:refugio/models/medicao.dart';
import 'package:refugio/models/ponto_refugio.dart';
import 'package:refugio/models/recurso_ponto.dart';

class PontoRepository {
  PontoRepository() {
    final temperaturas = [
      29.4,
      31.1,
      33.2,
      30.0,
      34.5,
      28.7,
      32.0,
      27.9,
      30.9,
      35.0,
    ];
    final umidades = [
      61.0,
      57.0,
      49.0,
      67.0,
      44.0,
      72.0,
      53.0,
      75.0,
      58.0,
      38.0,
    ];
    for (int i = 0; i < pontos.length; i++) {
      medicoes.add(
        Medicao(
          id: i + 1,
          pontoId: pontos[i].id,
          temperaturaC: temperaturas[i],
          umidadePct: umidades[i],
          origem: 'SIMULADA',
          medidaEm: DateTime.utc(2026, 11, 9, 10, i + 1),
        ),
      );
    }
  }

  final List<PontoRefugio> pontos = [
    PontoRefugio(
      id: 1,
      codigoPublico: 'REF-001',
      nome: 'Centro de Apoio Aurora',
      bairro: 'Centro Piloto',
      horarioTexto: '08:00–18:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 2,
      codigoPublico: 'REF-002',
      nome: 'Espaço Sombra Clara',
      bairro: 'Vila Solar',
      horarioTexto: '09:00–17:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 3,
      codigoPublico: 'REF-003',
      nome: 'Ponto Jardim Brisa',
      bairro: 'Jardim Piloto',
      horarioTexto: '07:00–19:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 4,
      codigoPublico: 'REF-004',
      nome: 'Sala Comunitária Horizonte',
      bairro: 'Parque Modelo',
      horarioTexto: '08:00–16:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 5,
      codigoPublico: 'REF-005',
      nome: 'Estação Sol Nascente',
      bairro: 'Centro Piloto',
      horarioTexto: '06:00–20:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 6,
      codigoPublico: 'REF-006',
      nome: 'Abrigo Caminho Verde',
      bairro: 'Vila Solar',
      horarioTexto: '10:00–18:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 7,
      codigoPublico: 'REF-007',
      nome: 'Espaço Descanso Azul',
      bairro: 'Jardim Piloto',
      horarioTexto: '08:00–18:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 8,
      codigoPublico: 'REF-008',
      nome: 'Base Comunitária Ipê',
      bairro: 'Parque Modelo',
      horarioTexto: '09:00–19:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 9,
      codigoPublico: 'REF-009',
      nome: 'Ponto Alameda Serena',
      bairro: 'Centro Piloto',
      horarioTexto: '07:00–17:00',
      status: 'ATIVO',
    ),
    PontoRefugio(
      id: 10,
      codigoPublico: 'REF-010',
      nome: 'Estação Respiro',
      bairro: 'Vila Solar',
      horarioTexto: '08:00–20:00',
      status: 'INATIVO',
    ),
  ];

  final List<RecursoPonto> recursos = [
    RecursoPonto(id: 1, pontoId: 1, tipo: 'AGUA', disponivel: true),
    RecursoPonto(id: 2, pontoId: 1, tipo: 'SOMBRA', disponivel: true),
    RecursoPonto(id: 3, pontoId: 2, tipo: 'SOMBRA', disponivel: true),
    RecursoPonto(id: 4, pontoId: 2, tipo: 'ASSENTO', disponivel: true),
    RecursoPonto(id: 5, pontoId: 3, tipo: 'AGUA', disponivel: false),
    RecursoPonto(id: 6, pontoId: 3, tipo: 'ASSENTO', disponivel: true),
    RecursoPonto(id: 7, pontoId: 4, tipo: 'ASSENTO', disponivel: true),
    RecursoPonto(id: 8, pontoId: 4, tipo: 'ACESSIBILIDADE', disponivel: true),
    RecursoPonto(id: 9, pontoId: 5, tipo: 'AGUA', disponivel: true),
    RecursoPonto(id: 10, pontoId: 5, tipo: 'ACESSIBILIDADE', disponivel: true),
    RecursoPonto(id: 11, pontoId: 6, tipo: 'SOMBRA', disponivel: true),
    RecursoPonto(id: 12, pontoId: 6, tipo: 'ACESSIBILIDADE', disponivel: false),
    RecursoPonto(id: 13, pontoId: 7, tipo: 'AGUA', disponivel: true),
    RecursoPonto(id: 14, pontoId: 7, tipo: 'ASSENTO', disponivel: true),
    RecursoPonto(id: 15, pontoId: 8, tipo: 'AGUA', disponivel: true),
    RecursoPonto(id: 16, pontoId: 8, tipo: 'SOMBRA', disponivel: true),
    RecursoPonto(id: 17, pontoId: 9, tipo: 'SOMBRA', disponivel: true),
    RecursoPonto(id: 18, pontoId: 9, tipo: 'ASSENTO', disponivel: true),
    RecursoPonto(id: 19, pontoId: 10, tipo: 'AGUA', disponivel: false),
    RecursoPonto(id: 20, pontoId: 10, tipo: 'ACESSIBILIDADE', disponivel: true),
  ];

  final List<Medicao> medicoes = [];

  List<PontoRefugio> buscarPontos({String busca = '', String bairro = ''}) {
    final List<PontoRefugio> resultado = [];
    final texto = busca.trim().toLowerCase();
    final bairroBuscado = bairro.trim().toLowerCase();
    for (final ponto in pontos) {
      if (ponto.status == 'ATIVO' &&
          (ponto.nome.toLowerCase().contains(texto) ||
              ponto.codigoPublico.toLowerCase().contains(texto)) &&
          ponto.bairro.toLowerCase().contains(bairroBuscado)) {
        resultado.add(ponto);
      }
    }
    return resultado;
  }

  PontoRefugio? buscarPorCodigo(String codigo) {
    for (final ponto in pontos) {
      if (ponto.codigoPublico == codigo) return ponto;
    }
    return null;
  }

  PontoRefugio? buscarPorId(int id) {
    for (final ponto in pontos) {
      if (ponto.id == id) return ponto;
    }
    return null;
  }

  List<RecursoPonto> buscarRecursos(int pontoId) {
    final List<RecursoPonto> resultado = [];
    for (final recurso in recursos) {
      if (recurso.pontoId == pontoId) resultado.add(recurso);
    }
    return resultado;
  }

  Medicao? buscarUltimaMedicao(int pontoId) {
    Medicao? ultima;
    for (final medicao in medicoes) {
      if (medicao.pontoId == pontoId &&
          (ultima == null || medicao.medidaEm.isAfter(ultima.medidaEm))) {
        ultima = medicao;
      }
    }
    return ultima;
  }
}
