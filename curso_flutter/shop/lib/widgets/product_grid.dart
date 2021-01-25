import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Agora ao invés de usarmos o loadedProducts a partir
    //de DUMMY_PRODUCTS, o usaremos a partir do provider:
    // final List<Product> loadedProducts = Provider
    //   .of<Products>(context).items;

    //Ou podemos fazer isso:
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.items;
    
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(
        products[index]
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
    );
  }
}