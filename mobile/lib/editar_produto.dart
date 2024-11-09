import 'dart:convert';
import 'package:mobile/produto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EditarProdutoScreen extends StatefulWidget {
  final int produtoId;

  EditarProdutoScreen({required this.produtoId});

  @override
  _EditarProdutoScreenState createState() => _EditarProdutoScreenState();
}

class _EditarProdutoScreenState extends State<EditarProdutoScreen> {
  late TextEditingController nomeController;
  late TextEditingController precoController;
  late TextEditingController quantidadeController;
  late TextEditingController dataVencimentoController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> editarProduto(int id, Produto produto) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/Produtos/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(produto.toJson()),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        print("Produto editado com sucesso!");
      } else {
        print("Erro ao editar o produto: ${response.statusCode}");
      }
    } catch (err) {
      print("Erro na requisição: $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: quantidadeController,
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dataVencimentoController,
              decoration: InputDecoration(labelText: 'Data de Vencimento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final nome = nomeController.text;
                final preco = double.parse(precoController.text);
                final quantidade = int.parse(quantidadeController.text);
                final dataVencimento =
                    DateTime.parse(dataVencimentoController.text);

                await editarProduto(
                    widget.produtoId, nome, preco, quantidade, dataVencimento);
                Navigator.pop(context);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
