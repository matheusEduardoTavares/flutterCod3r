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
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Agora precisamos por aqui passar como provider
    //também o carrinho. Para passar mais de um 
    //provider para toda aplicação para que 
    //consigamos passar tanto o produto como do 
    //carrinho via provider para a nossa aplicação.
    //Para isso, precisamos usar o MultiProvider.
    //Trocamos o ChangeNotifierProvider pelo 
    //MultiProvider.
    // return ChangeNotifierProvider(
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
    return MultiProvider(
      //Passamos para o MultiProviders o 
      //atributo providers que irá receber uma 
      //lista que irá conter todos os providers 
      //da aplicação. Nele, passamos todos os 
      //ChangeNotifier que queremos, tudo que 
      //queremos fazer o provider prover naquele
      //momento. Haverá conter os atributos create
      //e value normalmente. Precisaremos tanto
      //do carrinho quanto do produto desde a 
      //raíz da aplicação, pois desde a tela 
      //home precisaremos usar esses dados.
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products()
        ),
        ChangeNotifierProvider(
          create: (_) => Cart()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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