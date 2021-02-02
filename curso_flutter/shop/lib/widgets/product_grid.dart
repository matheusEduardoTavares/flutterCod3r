import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    //Agora ao invés de usarmos o loadedProducts a partir
    //de DUMMY_PRODUCTS, o usaremos a partir do provider:
    // final List<Product> loadedProducts = Provider
    //   .of<Products>(context).items;

    //Ou podemos fazer isso:
    final productsProvider = Provider.of<Products>(context);
    final products = showFavoriteOnly ? 
      productsProvider.favoriteItems : 
      productsProvider.items;

    if (products.isEmpty)
      return Center(
        child: Text(
          'Não há nenhum item favoritado !',
          style: TextStyle(
            fontSize: 38,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 0.5,
                color: Colors.red,
                offset: Offset(1, 1)
              ),
              Shadow(
                blurRadius: 0.5,
                color: Colors.black,
                offset: Offset(1.5, 1.5)
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      //Iremos fazer u mwrap do ProductItem com o 
      //ChangeNotifierProvider para podermos usar o 
      //Provider.of(context) e acessar se o produto é
      //favorito ou não
      //Aqui não estamos mais criando um novo
      //ChangeNotifier, e sim usando um que já 
      //foi criado anteriormente, o do main.dart.
      //O ideal é usar o método create apenas para 
      //criar um novo ChangeNotifier. Quando
      //retornamos uma instância pré-existente, 
      //devemos usar o ChangeNotifier com o 
      //construtor .value, e não o ChangeNotifier
      //normal. Ao reusar uma instância já existente,
      //que é quando temos dois ChangeNotifier com 
      //create. Temos as 3 árvores, e pelo fato de 
      //reusarmos alguns elementos quando há uma 
      //mudança na interface gráfica, isso pode gerar
      //alguns bugs caso não respeitemos essa 
      //sugestão da documentação. É oque faremos
      //aqui, substituiremos o ChangeNotifierProvider pelo
      //ChangeNotifierProvider.value, e trocaremos o 
      //create por value, deixando de passar uma função
      //e passando o produto na posição index direto.
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        //Veremos o create melhor mais na frente, mas é 
        //a partir dele que pegamos a informação que 
        //precisamos.
        value: products[index],
        child: ProductItem(),
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