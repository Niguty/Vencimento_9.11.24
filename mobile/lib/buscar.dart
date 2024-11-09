import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/categoria.dart';
import 'package:mobile/produto.dart';

class SearchScreen extends StatefulWidget {
  final List<Produto> produtos;

  SearchScreen({required this.produtos});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Produto> _produtosFiltrados = [];
  TextEditingController _categoriaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _produtosFiltrados = widget.produtos;
  }

  void _buscarPorCategoria() {
    String categoria = _categoriaController.text.toLowerCase();
    setState(() {
      if (categoria.isEmpty) {
        _produtosFiltrados = widget.produtos;
      } else {
        _produtosFiltrados = widget.produtos
            .where((produto) =>
                produto.categoria.nome.toLowerCase().contains(categoria))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Produtos por Categoria'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: Key('categoriaField'),
              controller: _categoriaController,
              decoration: InputDecoration(
                hintText: 'Buscar por Categoria',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            key: Key('buscarButton'),
            onPressed: _buscarPorCategoria,
            child: Text('Buscar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _produtosFiltrados.length,
              itemBuilder: (context, index) {
                final produto = _produtosFiltrados[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(
                      'Vence em: ${DateFormat('dd-MM-yy').format(produto.dataVencimento)}'),
                  trailing: Text('Qtd: ${produto.quantidade}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
