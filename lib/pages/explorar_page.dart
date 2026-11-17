import 'package:flutter/material.dart';
import 'package:refugio/models/ponto_refugio.dart';
import 'package:refugio/pages/detalhe_ponto_page.dart';
import 'package:refugio/pages/favoritos_page.dart';
import 'package:refugio/pages/meus_relatos_page.dart';
import 'package:refugio/repositories/favorito_repository.dart';
import 'package:refugio/repositories/ocorrencia_repository.dart';
import 'package:refugio/repositories/ponto_repository.dart';
import 'package:refugio/widgets/ponto_list_item.dart';

class ExplorarPage extends StatefulWidget {
  const ExplorarPage({super.key});

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  final PontoRepository pontoRepository = PontoRepository();
  final FavoritoRepository favoritoRepository = FavoritoRepository();
  final OcorrenciaRepository ocorrenciaRepository = OcorrenciaRepository();
  final TextEditingController buscaController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  String busca = '';
  String bairro = '';

  @override
  void dispose() {
    buscaController.dispose();
    bairroController.dispose();
    super.dispose();
  }

  Future<void> abrirPagina(Widget pagina) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => pagina));
    if (!mounted) return;
    setState(() {});
  }

  void abrirDetalhe(PontoRefugio ponto) {
    abrirPagina(
      DetalhePontoPage(
        codigoPublico: ponto.codigoPublico,
        pontoRepository: pontoRepository,
        favoritoRepository: favoritoRepository,
        ocorrenciaRepository: ocorrenciaRepository,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pontos = pontoRepository.buscarPontos(busca: busca, bairro: bairro);
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Uma pausa perto\ndo seu caminho.',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Veja os recursos de cada ponto antes de sair.',
              style: TextStyle(color: Color(0xff526561)),
            ),
            const SizedBox(height: 22),
            TextField(
              controller: buscaController,
              decoration: const InputDecoration(
                labelText: 'Nome ou código do ponto',
                hintText: 'Ex.: Jardim Brisa ou REF-003',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) => aplicarFiltros(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bairroController,
              decoration: const InputDecoration(
                labelText: 'Bairro',
                hintText: 'Ex.: Centro Piloto',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              onSubmitted: (value) => aplicarFiltros(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: aplicarFiltros,
                    child: const Text('Buscar pontos'),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: limparFiltros,
                  child: const Text('Limpar'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: () => abrirPagina(
                FavoritosPage(
                  pontoRepository: pontoRepository,
                  favoritoRepository: favoritoRepository,
                  ocorrenciaRepository: ocorrenciaRepository,
                ),
              ),
              child: Text(
                'Favoritos (${favoritoRepository.codigosFavoritos.length})',
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => abrirPagina(
                MeusRelatosPage(
                  pontoRepository: pontoRepository,
                  favoritoRepository: favoritoRepository,
                  ocorrenciaRepository: ocorrenciaRepository,
                ),
              ),
              child: const Text('Meus relatos'),
            ),
            const SizedBox(height: 24),
            Text(
              '${pontos.length} ${pontos.length == 1 ? 'ponto encontrado' : 'pontos encontrados'}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            if (pontos.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Nenhum ponto por aqui. Tente outro nome ou bairro.',
                ),
              ),
            for (final ponto in pontos)
              PontoListItem(
                ponto: ponto,
                recursos: pontoRepository.buscarRecursos(ponto.id),
                favorito: favoritoRepository.estaFavorito(ponto.codigoPublico),
                onAbrir: () => abrirDetalhe(ponto),
                onFavoritar: () {
                  setState(
                    () => favoritoRepository.alternarFavorito(
                      ponto.codigoPublico,
                    ),
                  );
                },
              ),
            const SizedBox(height: 8),
            const Text(
              'Dados demonstrativos. Confirme local e horários antes de usar.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xff526561),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void aplicarFiltros() {
    FocusScope.of(context).unfocus();
    setState(() {
      busca = buscaController.text;
      bairro = bairroController.text;
    });
  }

  void limparFiltros() {
    buscaController.clear();
    bairroController.clear();
    aplicarFiltros();
  }
}
