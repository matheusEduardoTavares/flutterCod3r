import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Essa tela irá representar uma tela
    //da aplicação e terá as tabs que 
    //irá navegar entre as 2 telas.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vamos Cozinhar ?'),
          //Na parte de baixo do AppBar podemos colocar
          //as tabs
          bottom: TabBar(
            tabs: <Widget> [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categorias'
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favoritos'
              )
            ]
          )
        ),
        body: TabBarView(
          children: <Widget> [
            //Associado a primeira aba:
            CategoriesScreen(),
            FavoriteScreen()
          ],
        )
      )
    );
  }
}