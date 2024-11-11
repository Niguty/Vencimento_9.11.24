import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DeletarProdutoScreen extends StatelessWidget {
  final int produtoId;

  DeletarProdutoScreen({required this.produtoId});

  Future<void> _deletarProduto(int id) async {

    final response = await http.delete(
      Uri.parse('http://localhost:3000/Produtos/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Produto deletado com sucesso!');
    } else {
      print('Falha ao deletar produto.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deletar Produto'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _deletarProduto(produtoId);
            Navigator.pop(context);
          },
          child: Text('Confirmar Exclusão'),
        ),
      ),
    );
  }
}
