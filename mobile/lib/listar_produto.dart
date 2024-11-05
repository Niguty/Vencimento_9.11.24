import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/produto.dart';


class AdicionarProduto extends StatefulWidget {
  final Function(Produto) onProdutoAdicionado;

  AdicionarProduto({required this.onProdutoAdicionado});

  @override
  _AdicionarProdutoState createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {
  final _nomeController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();
  DateTime? _dataVencimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: 'Categoria'),
            ),
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (data != null) {
                  setState(() {
                    _dataVencimento = data;
                  });
                }
              },
              child: Text(_dataVencimento == null
                  ? 'Escolher Data de Vencimento'
                  : 'Vencimento: ${DateFormat('dd-MM-yyyy').format(_dataVencimento!)}'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_nomeController.text.isEmpty ||
                    _categoriaController.text.isEmpty ||
                    _quantidadeController.text.isEmpty ||
                    _precoController.text.isEmpty ||
                    _dataVencimento == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha todos os campos')),
                  );
                  return;
                }

                final novoProduto = Produto(
                  id: DateTime.now().millisecondsSinceEpoch,
                  nome: _nomeController.text,
                  categoria: _categoriaController.text,
                  dataVencimento: _dataVencimento!,
                  quantidade: int.parse(_quantidadeController.text),
                  preco: double.parse(_precoController.text),
                );
                widget.onProdutoAdicionado(novoProduto);
                Navigator.pop(context);
              },
              child: Text('Adicionar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}