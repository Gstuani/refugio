import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:refugio/pages/relatar_problema_page.dart';
import 'package:refugio/repositories/favorito_repository.dart';
import 'package:refugio/repositories/ocorrencia_repository.dart';
import 'package:refugio/repositories/ponto_repository.dart';

class DetalhePontoPage extends StatefulWidget {
  const DetalhePontoPage({
    super.key,
    required this.codigoPublico,
    required this.pontoRepository,
    required this.favoritoRepository,
    required this.ocorrenciaRepository,
  });

  final String codigoPublico;
  final PontoRepository pontoRepository;
  final FavoritoRepository favoritoRepository;
  final OcorrenciaRepository ocorrenciaRepository;

  @override
  State<DetalhePontoPage> createState() => _DetalhePontoPageState();
}

class _DetalhePontoPageState extends State<DetalhePontoPage> {
  @override
  Widget build(BuildContext context) {
    final ponto = widget.pontoRepository.buscarPorCodigo(widget.codigoPublico);
    if (ponto == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes do ponto')),
        body: const Center(
          child: Text('Não encontramos esse ponto. Volte e escolha outro.'),
        ),
      );
    }
    final recursos = widget.pontoRepository.buscarRecursos(ponto.id);
    final medicao = widget.pontoRepository.buscarUltimaMedicao(ponto.id);
    final favorito = widget.favoritoRepository.estaFavorito(
      ponto.codigoPublico,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do ponto')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Icon(
              Icons.wb_shade_rounded,
              size: 60,
              color: Color(0xff39775c),
            ),
            const SizedBox(height: 22),
            Text(
              '${ponto.codigoPublico} · ${ponto.bairro}',
              style: const TextStyle(
                color: Color(0xff39775c),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              ponto.nome,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Text(
              '${ponto.logradouro}, ${ponto.numero}\n${ponto.bairro} · ${ponto.cidade} / ${ponto.uf}',
              style: const TextStyle(height: 1.6),
            ),
            const SizedBox(height: 12),
            Text('Horário informado: ${ponto.horarioTexto}'),
            const SizedBox(height: 6),
            Text(
              ponto.status == 'ATIVO' ? 'Cadastro ativo' : 'Cadastro inativo',
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                setState(
                  () => widget.favoritoRepository.alternarFavorito(
                    ponto.codigoPublico,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    favorito ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      favorito
                          ? 'Remover dos favoritos'
                          : 'Salvar nos favoritos',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'O que você encontra',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            if (recursos.isEmpty)
              const Text('Ainda não há recursos cadastrados.'),
            for (final recurso in recursos)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      recurso.disponivel
                          ? Icons.check_circle_outline
                          : Icons.remove_circle_outline,
                      color: recurso.disponivel
                          ? const Color(0xff39775c)
                          : const Color(0xff945f28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${recurso.nome}\n${recurso.disponivel ? 'Disponível' : 'Indisponível'}',
                        style: const TextStyle(height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            const Text(
              'Última medição',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffe0ede5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: medicao == null
                  ? const Text('Sem medição')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${medicao.temperaturaC.toStringAsFixed(1).replaceAll('.', ',')} °C',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Umidade: ${medicao.umidadePct.toStringAsFixed(0)}%',
                        ),
                        const SizedBox(height: 8),
                        Text('Origem: ${medicao.origem}'),
                        Text(
                          '${DateFormat('dd/MM/yyyy · HH:mm').format(medicao.medidaEm.toUtc())} UTC',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          medicao.classificacao == 'ATENCAO_DIDATICA'
                              ? 'Atenção didática · temperatura a partir de 32 °C'
                              : 'Informativo · temperatura abaixo de 32 °C',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Leitura simulada para o projeto. Não é um alerta de saúde nem uma leitura ao vivo.',
                          style: TextStyle(fontSize: 12, height: 1.5),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: ponto.status != 'ATIVO'
                  ? null
                  : () async {
                      final enviado = await Navigator.of(context).push<bool>(
                        MaterialPageRoute(
                          builder: (context) => RelatarProblemaPage(
                            ponto: ponto,
                            ocorrenciaRepository: widget.ocorrenciaRepository,
                          ),
                        ),
                      );
                      if (!context.mounted || enviado != true) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Relato registrado (demonstração)'),
                        ),
                      );
                    },
              child: const Text('Relatar um problema'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Dados demonstrativos. Confirme local e horários antes de usar.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff526561),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
