imprimirProduto(int qtde, {String nome, double preco}) {
  for (int i = 0; i < qtde; i++){
    print("O produto $nome tem preço R\$${preco.toStringAsFixed(2)}");
  }
}

class Produto {
  String nome;
  double preco;

  Produto();
  Produto.comParametrosPosicionais(this.nome, this.preco);
  Produto.comParametrosNomeados({this.nome, this.preco = 19.99});
}

void main(){
  var p1 = new Produto();
  p1.nome = 'Lápis';
  p1.preco = 4.59;

  print("O produto ${p1.nome} tem preço R\$${p1.preco}");

  var p2 = Produto.comParametrosPosicionais('Geladeira', 1454.99);

  //Números de casas decimais:
  print("O produto ${p2.nome} tem preço R\$${p2.preco.toStringAsFixed(2)}");

  var p3 = Produto.comParametrosNomeados(nome: 'Caderno');
  imprimirProduto(2, nome: p3.nome, preco: p3.preco);
}