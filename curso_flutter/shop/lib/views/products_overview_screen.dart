import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  
  final List<Product> loadedProducts = DUMMY_PRODUCTS;

  ProductOverviewScreen({
    Key key
  }) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, index) => ProductItem(
          loadedProducts[index]
        ),
        //O gridDelegate que usaremos aqui agora, basicamente
        //o sliver é uma área que permite scroll, o grid delegate é
        //como será delegado os itens do grid, que no caso
        //irá ter uma quantidade fixa de elementos no eixo X
        //crossAxis.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //No crossAxisCount passamos quantos elementos
          //no eixo X queremos ter
          crossAxisCount: 2,
          //No childAspectRatio passamos qual é o 
          //aspectRatio dos elementos dentro da 
          //grid. Por exemplo uma tela wide é 
          //16/9, basicamente é se a altura é 
          //igual a largura (1 / 1)
          childAspectRatio: 3 / 2,
          //Espaçamento no eixo X dos elementos:
          crossAxisSpacing: 10,
          //Espaçamento no eixo X dos elementos:
          mainAxisSpacing: 10
        ),
      )
    );
  }
}