import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:refugio/models/ocorrencia.dart';
import 'package:refugio/pages/detalhe_ponto_page.dart';
import 'package:refugio/repositories/favorito_repository.dart';
import 'package:refugio/repositories/ocorrencia_repository.dart';
import 'package:refugio/repositories/ponto_repository.dart';

class MeusRelatosPage extends StatefulWidget {
  const MeusRelatosPage({
    super.key,
    required this.pontoRepository,
    required this.favoritoRepository,
    required this.ocorrenciaRepository,
  });

  final PontoRepository pontoRepository;
  final FavoritoRepository favoritoRepository;
  final OcorrenciaRepository ocorrenciaRepository;

  @override
  State<MeusRelatosPage> createState() => _MeusRelatosPageState();
}

class _MeusRelatosPageState extends State<MeusRelatosPage> {
  Future<void> abrirResumo(Ocorrencia relato) async {
    final ponto = widget.pontoRepository.buscarPorId(relato.pontoId);
    final abrirPonto = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(relato.nomeCategoria),
        content: SingleChildScrollView(
          child: Text(
            '${ponto?.nome ?? 'Ponto não encontrado'}\n\n${relato.descricao}\n\nStatus: ${relato.nomeStatus}\nPrioridade: ${relato.nomePrioridade}\nRegistrado em ${DateFormat('dd/MM/yyyy · HH:mm').format(relato.abertaEm)}${relato.resolvidaEm == null ? '' : '\nResolvido em ${DateFormat('dd/MM/yyyy · HH:mm').format(relato.resolvidaEm!)}'}\n\nRelato de demonstração.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Fechar'),
          ),
          if (ponto != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ver ponto'),
            ),
        ],
      ),
    );
    if (!mounted || abrirPonto != true || ponto == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetalhePontoPage(
          codigoPublico: ponto.codigoPublico,
          pontoRepository: widget.pontoRepository,
          favoritoRepository: widget.favoritoRepository,
          ocorrenciaRepository: widget.ocorrenciaRepository,
        ),
      ),
    );
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final relatos = widget.ocorrenciaRepository.buscarMeusRelatos();
    return Scaffold(
      appBar: AppBar(title: const Text('Meus relatos')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Sua contribuição\nfaz parte do caminho.',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Relatos do perfil de demonstração. Os dois registros iniciais são exemplos.',
              style: TextStyle(color: Color(0xff526561), height: 1.5),
            ),
            const SizedBox(height: 18),
            Text(
              '${relatos.length} ${relatos.length == 1 ? 'relato' : 'relatos'}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            if (relatos.isEmpty)
              const Text(
                'Você ainda não tem relatos. Abra um ponto para contar o que encontrou.',
              ),
            for (final relato in relatos)
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffdde6df)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relato.nomeStatus,
                      style: const TextStyle(
                        color: Color(0xff39775c),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      relato.nomeCategoria,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.pontoRepository
                              .buscarPorId(relato.pontoId)
                              ?.nome ??
                          'Ponto não encontrado',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      relato.descricao,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Prioridade: ${relato.nomePrioridade}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy · HH:mm').format(relato.abertaEm),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff526561),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => abrirResumo(relato),
                      child: const Text('Ver relato →'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
