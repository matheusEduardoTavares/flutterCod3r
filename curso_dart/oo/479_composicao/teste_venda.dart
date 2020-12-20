import './cliente.dart';
import './venda.dart';
import './produto.dart';
import './venda_item.dart';

main(){
  var vendaItem1 = VendaItem(
    quantidade: 30,
    produto: Produto(
      codigo: 1,
      nome: 'Lápis Preto',
      preco: 6.00,
      desconto: 0.5
    ),
  );

  var venda = Venda(
    cliente: Cliente(
      nome: 'Francisco Cardoso',
      cpf: '123.456.789-00'
    ),
    itens: <VendaItem>[
      vendaItem1,
      VendaItem(
        quantidade: 20,
        produto: Produto(
          codigo: 123,
          nome: 'Caderno',
          preco: 20.00,
          desconto: 0.25
        )
      ),
      VendaItem(
        quantidade: 100,
        produto: Produto(
          codigo: 52,
          nome: 'Borracha',
          preco: 2.00,
          desconto: 0.5
        )
      )
    ]
  );

  var pegarApenasONomeDosProdutos = (nome) => nome.produto.nome;
  var nomesProdutos = venda.itens.map(pegarApenasONomeDosProdutos);
  print('Nomes dos produtos: ${nomesProdutos.toList()}');

  print('O valor total da venda é: R\$${venda.valorTotal}');
  //O valor total da venda é: R$490.0

  print('Nome do primeiro produto é: ${venda.itens[0].produto.nome}');
  //Nome do primeiro produto é: Lápis Preto

  print('O CPF do cliente é: ${venda.cliente.cpf}');
  //O CPF do cliente é: 123.456.789-00
}