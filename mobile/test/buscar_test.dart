import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mobile/buscar.dart';
import 'package:mobile/produto.dart';
import 'package:mobile/categoria.dart';

void main() {
  testWidgets('Filtro por categoria deve retornar os produtos corretos',
      (WidgetTester tester) async {
    final produtos = [
      Produto(
        id: 1,
        nome: 'Pepsi',
        categoria: Categoria(id: 1, nome: 'Bebida'),
        dataVencimento: DateTime.now(),
        quantidade: 10,
        preco: 4.99,
      ),
      Produto(
        id: 2,
        nome: 'Arroz',
        categoria: Categoria(id: 2, nome: 'Comida'),
        dataVencimento: DateTime.now(),
        quantidade: 5,
        preco: 19.99,
      ),
    ];

    await tester.pumpWidget(MaterialApp(
      home: SearchScreen(produtos: produtos),
    ));

    final categoriaField = find.byKey(Key('categoriaField'));
    await tester.enterText(categoriaField, 'Bebida');
    await tester.tap(find.byKey(Key('buscarButton')));
    await tester.pump();

    final produtosFiltrados = tester.widgetList(find.byType(ListTile));
    expect(produtosFiltrados.length, 1);

    produtosFiltrados.forEach((produto) {
      final produtoWidget = produto as ListTile;
      expect(produtoWidget.title.toString().contains('Pepsi'), isTrue);
    });
  });
}
