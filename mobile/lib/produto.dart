import 'package:intl/intl.dart';
import 'package:mobile/categoria.dart';

class Produto {
  final int id;
  final String nome;
  final Categoria categoria;
  final DateTime dataVencimento;
  final int quantidade;
  final double preco;

  Produto({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.dataVencimento,
    required this.quantidade,
    required this.preco,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'dataVencimento': DateFormat('dd/MM/yyyy').format(dataVencimento),
      'quantidade': quantidade,
      'preco': preco,
    };
  }

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      categoria: Categoria.fromJson(json['categoria']),
      dataVencimento: DateFormat('dd/MM/yyyy').parse(json['dataVencimento']),
      quantidade: json['quantidade'],
      preco: json['preco'],
    );
  }
}
