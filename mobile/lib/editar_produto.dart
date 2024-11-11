import 'dart:convert';
import 'package:mobile/produto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditarProdutoScreen extends StatefulWidget {
  final Produto produto;
  final Function(Produto) onProdutoEditado;

  EditarProdutoScreen({
    required this.produto,
    required this.onProdutoEditado,
  });

  @override
  _EditarProdutoScreenState createState() => _EditarProdutoScreenState();
}

class _EditarProdutoScreenState extends State<EditarProdutoScreen> {
  late TextEditingController nomeController;
  late TextEditingController precoController;
  late TextEditingController quantidadeController;
  late TextEditingController dataVencimentoController;
  late TextEditingController idController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.produto.nome);
    precoController =
        TextEditingController(text: widget.produto.preco.toString());
    quantidadeController =
        TextEditingController(text: widget.produto.quantidade.toString());
    dataVencimentoController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(widget.produto.dataVencimento),
    );
    idController = TextEditingController(text: widget.produto.id.toString()); 
  }

  @override
  void dispose() {
    nomeController.dispose();
    precoController.dispose();
    quantidadeController.dispose();
    dataVencimentoController.dispose();
    idController.dispose();
    super.dispose();
  }

  Future<void> _editarProduto(Produto produto, int id) async {
  print('Produto ID: $id');

  try {
    final response = await http.put(
  Uri.parse('http://localhost:3000/Produtos/${produto.id}'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(produto.toJson()),
);


    if (response.statusCode == 200) {
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
              controller: idController,
              decoration: InputDecoration(labelText: 'ID do Produto'),
              keyboardType: TextInputType.number,
            ),
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
              decoration:
                  InputDecoration(labelText: 'Data de Vencimento (yyyy-MM-dd)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final nome = nomeController.text;
                  final preco = double.tryParse(precoController.text) ?? 0;
                  final quantidade = int.tryParse(quantidadeController.text) ?? 0;
                  final dataVencimento = DateTime.tryParse(dataVencimentoController.text);
                  final id = int.tryParse(idController.text) ?? 0;

                  if (dataVencimento == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data de vencimento inválida.")),
                    );
                    return;
                  }

                  final atualizarProduto = Produto(
                   id: widget.produto.id,  
                   nome: nome,
                   dataVencimento: dataVencimento,
                   quantidade: quantidade,
                   categoria: widget.produto.categoria,
                   preco: preco,
);


                  widget.onProdutoEditado(atualizarProduto);
                  await _editarProduto(atualizarProduto, id);
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erro ao salvar as alterações.")),
                  );
                }
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
