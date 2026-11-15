import 'package:flutter/material.dart';
import 'package:refugio/models/ponto_refugio.dart';
import 'package:refugio/models/recurso_ponto.dart';

class PontoListItem extends StatelessWidget {
  const PontoListItem({
    super.key,
    required this.ponto,
    required this.recursos,
    required this.favorito,
    required this.onAbrir,
    required this.onFavoritar,
  });

  final PontoRefugio ponto;
  final List<RecursoPonto> recursos;
  final bool favorito;
  final VoidCallback onAbrir;
  final VoidCallback onFavoritar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffdde6df)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ponto.bairro,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff39775c),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                tooltip: favorito
                    ? 'Remover ${ponto.nome} dos favoritos'
                    : 'Favoritar ${ponto.nome}',
                onPressed: onFavoritar,
                icon: Icon(
                  favorito ? Icons.favorite : Icons.favorite_border,
                  color: const Color(0xff145c56),
                ),
              ),
            ],
          ),
          Text(
            ponto.nome,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            '${ponto.codigoPublico} · ${ponto.horarioTexto}',
            style: const TextStyle(color: Color(0xff526561), fontSize: 13),
          ),
          const SizedBox(height: 16),
          for (final recurso in recursos)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(
                    recurso.disponivel
                        ? Icons.check_circle_outline
                        : Icons.remove_circle_outline,
                    size: 17,
                    color: recurso.disponivel
                        ? const Color(0xff39775c)
                        : const Color(0xff945f28),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      '${recurso.nome} · ${recurso.disponivel ? 'Disponível' : 'Indisponível'}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          TextButton(onPressed: onAbrir, child: const Text('Ver detalhes →')),
        ],
      ),
    );
  }
}
