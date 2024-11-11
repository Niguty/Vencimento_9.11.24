import 'package:flutter/material.dart';
import 'package:mobile/buscar.dart';
import 'package:mobile/editar_produto.dart';
import 'package:mobile/listar_produto.dart';
import 'package:mobile/produto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Produto> _produtos = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _adicionarProduto(Produto produto) {
    setState(() {
      final novoProduto = Produto(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: produto.nome,
        categoria: produto.categoria,
        dataVencimento: produto.dataVencimento,
        quantidade: produto.quantidade,
        preco: produto.preco,
      );
      _produtos.add(novoProduto);
    });
  }

  void editarProduto(Produto produto) {
    setState(() {
      final index = _produtos.indexWhere((p) => p.id == produto.id);
      if (index != -1) {
        _produtos[index] = produto;
      }
    });
  }


  void deletarProduto(int id) {
    setState(() {
      _produtos.removeWhere((produto) => produto.id == id);
    });
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(
            produtos: _produtos,
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdicionarProduto(
            onProdutoAdicionado: _adicionarProduto,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerência de Vencimentos'),
        backgroundColor: const Color.fromARGB(255, 59, 125, 224),
      ),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final produto = _produtos[index];
          return ListTile(
            title: Text(produto.nome),
            subtitle: Text(
                'Preço: ${produto.preco} - Quantidade: ${produto.quantidade}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarProdutoScreen(
                          produto: produto,
                          onProdutoEditado: (Produto produtoEditado) {
                            editarProduto(produtoEditado);
                          },
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    deletarProduto(produto.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar Produto',
          ),
        ],
      ),
    );
  }
}
