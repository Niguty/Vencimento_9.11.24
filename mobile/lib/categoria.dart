class Categoria {
  int id;
  String nome;

  Categoria({required this.id, required this.nome});

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome};
  }

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      nome: json['nome'],
    );
  }
}
