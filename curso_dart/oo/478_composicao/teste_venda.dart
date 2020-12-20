import 'cliente.dart';
import 'venda.dart';
import 'produto.dart';
import 'venda_item.dart';

main(){
  Cliente cliente = Cliente(nome: 'Cliente', cpf: '123456789-10');
  Produto maca = Produto(codigo: 1, desconto: 0.1, nome: 'Maçã', preco: 5.90);
  Produto pera = Produto(codigo: 2, nome: 'Pera', preco: 4.00);

  VendaItem vendaMaca = VendaItem(produto: maca, quantidade: 3);
  VendaItem vendaPera = VendaItem(produto: pera, quantidade: 1);
  List<VendaItem> todasVendas = [vendaMaca, vendaPera];
  
  Venda venda = Venda(cliente: cliente, itens: todasVendas);

  print('O cliente \'${venda.cliente}\' comprou os seguintes itens: ${venda.itens}, resultando no preço: R\$${venda.valorTotal.toStringAsPrecision(4)}');
}