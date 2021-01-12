import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import '../components/main_drawer.dart';

//Até que estávamos usando as abas na parte superior
//da tela o componente era StatelessWidget, mas
//a partir de quando precisamos fazer a aba na 
//parte inferior da tela, então convertemos para
//stateful, isso pois precisaremos controlar 
//manualmente qual tela ficará visível
class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  final List<Map<String, Object>> _screens = [
    { 'title': 'Lista de Categorias', 'screen': CategoriesScreen() },
    { 'title': 'Meus Favoritos', 'screen': FavoriteScreen() }
  ];
  // final List<String> _titlesAppBar = [
  //   'Lista de Categorias',
  //   'Meus Favoritos'
  // ];

  void _selectScreen(int index){
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
      //Na aula 185 - Adicionando TabBar na AppBar
      //foi-se adicionado as tabs dentro do Scaffold,
      //de forma que as abas ficam no topo, agora iremos
      //usar outra estratégia para fazer com que dessa 
      //vez as abas fiquem na parte de baixo.

      //Essa tela irá representar uma tela
      //da aplicação e terá as tabs que 
      //irá navegar entre as 2 telas.
      return DefaultTabController(
        //Temos a propriedade initialIndex onde colocamos
        //qual será a aba padrão. Por padrão ele é o 
        //índice 0.
        // initialIndex: 1,
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
    */
    return Scaffold(
      appBar: AppBar(
        // title: Text(_titlesAppBar[_selectedScreenIndex]),
        title: Text(_screens[_selectedScreenIndex]['title']),
        centerTitle: true,
      ),
      // Colocamos a drawer direto no scaffold também.
      // Só de adicionar uma drawer com um child irá aparecer
      // o ícone de menu na parte esquerda do scaffold, e 
      // esse ícone permite clicar e arir o drawer, e em cima do
      // drawer estará o que colocamos no child.
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'],
      //Para fazer as abas ficarem na parte inferior da tela,
      //devemos usar o bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedScreenIndex,
        // Para trabalhar com animação na transição das abas,
        // usamos o atributo type
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categorias'
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favoritos'
          )
        ]
      )
    );
  }
}