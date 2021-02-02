import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_grid.dart';
import '../providers/products.dart';

//Podemos querer controlar de forma global os filtros
//para poder mostrar apenas os produtos favoritos ou todos os
//produtos. Ou podemos controlar de forma local o filtro para
//mostrar apenas na tela. No caso como menu é associado a 
//esta tela, faz mais sentido controlarmos isso localmente.
enum FilterOptions {
  Favorite,
  All
}

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({
    Key key
  }) : super(key: key);

  @override 
  Widget build(BuildContext context){
    final Products products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        centerTitle: true,
        actions: <Widget> [
          // Temos um Widget chamado PopupMenuButton que
          // são aqueles 3 pontinhos que clicamos e é 
          // aberto um popup. Para usá-lo, basta passar
          // seu atributo itemBuilder que receberá uma 
          // função que por sua vez recebe um BuildContext,
          // e retorna uma lista de PopupMenuEntry que podem
          // ser PopupMenuItem. Podemos mudar seu ícone passando
          // o atributo icon para o PopupMenuButton, e cada um
          // dos PopupMenuItem tem um value, de forma que quando
          // o usuário clica em outra opção, a função 
          // onSelected é chamada e ela recebe como parâmetro o
          // value do PopupMenuItem que foi clicado. É 
          // interessante criarmos um enum para trabalhar com
          // os values dos PopupMenuItem.
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorite) {
                products.showFavoriteOnly();
              }
              else {
                products.showAll();
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All
              )
            ]
          )
        ]
      ),
      body: ProductGrid()
    );
  }
}