import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  //Mesmo quando temos um gerenciamento de estado
  //mais sofisticado na aplicação, ainda assim
  //passamos parâmetros de um componente para outro.
  //Mesmo tendo um gerenciamento + sofisticado na 
  //aplicação ainda assim teremos componentes 
  //stateful, então ainda assim passaremos parâmetros
  //tanto para stateful quanto para stateless, quanto
  //também teremos estados no stateful. Por exemplo um
  //botão que quando clicamos nele ele faz uma requisição
  //para pegar dados e queremos mostar um spinner, algo 
  //girando para deixar claro pro usuário que está sendo
  //feito um processamento. Se vai mostrar ou esconder
  //o spinner, não faz sentido colocar essa lógica / dado
  //que define se vai exibir ou não externalizado do 
  //componente, pois é algo inerente aquele componente,
  //então o ideal é que fique encapsulado dentro do 
  //componente. Já outras informações como por exemplo
  //quais são os produtos que estão no carrinho, aí sim
  //faz sentido externalizar isso pois tem vários 
  //componentes que usarão essa informação.

  // final Product product;

  // const ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),

    );
  }
}