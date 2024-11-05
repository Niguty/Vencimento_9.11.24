import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/buscar.dart';
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
      _produtos.add(produto);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(
            produtos: _produtos,
          ),
        ),
      );
    } else if (index == 2) {
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
            subtitle: Text('Vence em: ${DateFormat('dd-MM-yy').format(produto.dataVencimento)}'),
            trailing: Text('Qtd: ${produto.quantidade}'),
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

