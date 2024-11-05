class Produto {
 final int id;
 final String nome;
 final String categoria;
 final  DateTime dataVencimento;
 final  int quantidade;
 final  double preco;

  Produto({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.dataVencimento,
    required this.quantidade,
    required this.preco,
  });
}