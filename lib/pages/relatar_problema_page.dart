import 'package:flutter/material.dart';
import 'package:refugio/models/ocorrencia.dart';
import 'package:refugio/models/ponto_refugio.dart';
import 'package:refugio/repositories/ocorrencia_repository.dart';

class RelatarProblemaPage extends StatefulWidget {
  const RelatarProblemaPage({
    super.key,
    required this.ponto,
    required this.ocorrenciaRepository,
  });

  final PontoRefugio ponto;
  final OcorrenciaRepository ocorrenciaRepository;

  @override
  State<RelatarProblemaPage> createState() => _RelatarProblemaPageState();
}

class _RelatarProblemaPageState extends State<RelatarProblemaPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  String categoria = '';

  @override
  void dispose() {
    categoriaController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  void selecionarCategoria(String codigo) {
    setState(() {
      categoria = codigo;
      categoriaController.text = Ocorrencia.categorias[codigo]!;
    });
  }

  void enviarRelato() {
    if (!formKey.currentState!.validate()) return;
    widget.ocorrenciaRepository.adicionarRelato(
      pontoId: widget.ponto.id,
      categoria: categoria,
      descricao: descricaoController.text,
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatar problema')),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                'O que aconteceu?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                widget.ponto.nome,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.ponto.codigoPublico,
                style: const TextStyle(color: Color(0xff526561)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Escolha o problema',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              for (final codigo in Ocorrencia.categorias.keys)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: categoria == codigo
                          ? const Color(0xffe0ede5)
                          : Colors.white,
                    ),
                    onPressed: () => selecionarCategoria(codigo),
                    child: Row(
                      children: [
                        Icon(
                          categoria == codigo
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(Ocorrencia.categorias[codigo]!)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextFormField(
                controller: categoriaController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Problema selecionado',
                  hintText: 'Escolha uma opção acima',
                ),
                validator: (value) {
                  if (!Ocorrencia.categorias.containsKey(categoria)) {
                    return 'Escolha o tipo de problema.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descricaoController,
                minLines: 4,
                maxLines: 7,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Conte um pouco mais',
                  hintText: 'Descreva o que você encontrou no local.',
                  helperText: 'Entre 10 e 500 caracteres.',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  final descricao = (value ?? '').trim();
                  if (descricao.isEmpty) {
                    return 'Descreva o problema que você encontrou.';
                  }
                  if (descricao.length < 10) {
                    return 'Escreva pelo menos 10 caracteres.';
                  }
                  if (descricao.length > 500) {
                    return 'Use no máximo 500 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: enviarRelato,
                child: const Text('Enviar relato'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Este relato fica salvo apenas nesta demonstração. Nenhuma solicitação será enviada a um serviço público.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff526561),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
