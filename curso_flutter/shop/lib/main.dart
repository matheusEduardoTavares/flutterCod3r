import 'package:flutter/material.dart';
import 'package:shop/views/product_detail_screen.dart';
import './views/products_overview_screen.dart';
import './utils/app_routes.dart';
//Aqui iremos usar o provider que importamos. Temos que
//por o provider em um ponto da aplicação que todos os
//componentes que precisam ele, terão terão ele 
//disponível. Precisamos acessar esse provider a 
//partir de ProductOverviewScreen. Então iremos ter
//que fazer um wrap do MaterialApp com o 
//ChangeNotifierProvider, e esse ChangeNotifierProvider
//é do pacote que importamos.
import 'package:provider/provider.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //ALém de ter o child é obrigatório passar o
      //atributo create que recebe um método que 
      //por sua vez recebe um contexto e iremos usar
      //essa função para usar os products. Uma vez que
      //o Products é um ChangeNotifier e ele é child 
      //de um ChangeNotifierProvider, caso haja alguma
      //mudança em products em que chamamos o notify
      //Listeners, os interessados serão notificados.
      //Aqui estamos criando um novo ChangeNotifier,
      //no create.
      create: (_) => Products(),
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen()
        }
      ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Agora aqui estamos envolvendo a aplicação com o 
    //CounterProvider.
    return CounterProvider(
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen()
        }
      ),
    );
  }
}
*/