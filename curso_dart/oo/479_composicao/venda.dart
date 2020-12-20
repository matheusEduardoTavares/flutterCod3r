import './cliente.dart';
import './venda_item.dart';

class Venda {
  Cliente cliente;
  List<VendaItem> itens;

  //Sem o const dá erro ao definir uma lista como valor
  //padrão
  Venda({this.cliente, this.itens = const []});

  double get valorTotal {
    return itens.map((item) => item.preco * item.quantidade)
      .reduce((acumulador, atual) => acumulador + atual);
  }
}