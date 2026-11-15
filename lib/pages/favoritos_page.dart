import 'package:flutter/material.dart';
import 'package:refugio/models/ponto_refugio.dart';
import 'package:refugio/pages/detalhe_ponto_page.dart';
import 'package:refugio/repositories/favorito_repository.dart';
import 'package:refugio/repositories/ocorrencia_repository.dart';
import 'package:refugio/repositories/ponto_repository.dart';
import 'package:refugio/widgets/ponto_list_item.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({
    super.key,
    required this.pontoRepository,
    required this.favoritoRepository,
    required this.ocorrenciaRepository,
  });

  final PontoRepository pontoRepository;
  final FavoritoRepository favoritoRepository;
  final OcorrenciaRepository ocorrenciaRepository;

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    final List<PontoRefugio> favoritos = [];
    for (final ponto in widget.pontoRepository.buscarPontos()) {
      if (widget.favoritoRepository.estaFavorito(ponto.codigoPublico)) {
        favoritos.add(ponto);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Seus lugares de pausa.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              '${favoritos.length} ${favoritos.length == 1 ? 'ponto salvo' : 'pontos salvos'}',
              style: const TextStyle(color: Color(0xff526561)),
            ),
            const SizedBox(height: 24),
            if (favoritos.isEmpty) ...[
              const SizedBox(height: 28),
              const Icon(
                Icons.favorite_border,
                size: 64,
                color: Color(0xff39775c),
              ),
              const SizedBox(height: 20),
              const Text(
                'Seus favoritos aparecem aqui.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text(
                'Toque no coração de um ponto para encontrá-lo mais fácil depois.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.6),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Voltar aos pontos'),
              ),
            ],
            for (final ponto in favoritos)
              PontoListItem(
                ponto: ponto,
                recursos: widget.pontoRepository.buscarRecursos(ponto.id),
                favorito: true,
                onFavoritar: () {
                  setState(
                    () => widget.favoritoRepository.alternarFavorito(
                      ponto.codigoPublico,
                    ),
                  );
                },
                onAbrir: () async {
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
                },
              ),
          ],
        ),
      ),
    );
  }
}
