import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mobile/buscar.dart';
import 'package:mobile/produto.dart';

void main() {
  testWidgets('Filtro por categoria deve retornar os produtos corretos', (WidgetTester tester) async {
    final produtos = [
      Produto(id: 1, nome: 'Pepsi', categoria: 'Bebida', dataVencimento: DateTime.now(), quantidade: 10, preco: 4.99),
    ];

    await tester.pumpWidget(MaterialApp(
      home: SearchScreen(produtos: produtos),
    ));
    final categoriaField = find.byType(TextField);
    await tester.enterText(categoriaField, 'Bebida');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    final produtosFiltrados = tester.widgetList(find.byType(Produto)); 
    expect(produtosFiltrados.length, 0);

    produtosFiltrados.forEach((produto) {
      expect(produto, 'Bebida');
    });
  });
}
