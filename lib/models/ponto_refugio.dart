class PontoRefugio {
  PontoRefugio({
    required this.id,
    required this.codigoPublico,
    required this.nome,
    required this.bairro,
    required this.horarioTexto,
    required this.status,
  }) : logradouro = 'Rua Exemplo $id',
       numero = '100',
       cidade = 'Cidade Demonstrativa',
       uf = 'SP',
       cadastradoEm = DateTime(2026, 11, 9, 9);

  int id;
  String codigoPublico;
  String nome;
  String logradouro;
  String numero;
  String bairro;
  String cidade;
  String uf;
  String horarioTexto;
  String status;
  DateTime cadastradoEm;
}
