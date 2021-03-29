import 'package:flutter/material.dart';
import 'package:shop/application/application.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/utils/url_firebase.dart';
import 'package:shop/views/auth_home_screen.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'package:shop/views/product_form_screen.dart';
import 'package:shop/views/products_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';
import './utils/app_routes.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import 'views/orders_screen.dart';

Future<void> main() async {
  ///Temos que ter um arquivo chamado [.env] na raíz do projeto
  ///e dentro dele ter a variável [urlDatabase], a variável
  ///[urlAuth] e a variável [apiKey]. Essa separação entre os 3
  ///é feita devido ao fato que as URL's do firebase seguem um
  ///padrão, mudando apenas uma parte do recurso e no fim usando
  ///o key=[apiKey] como query param
  await DotEnv.load(fileName: ".env");

  UrlFirebase.urlDatabase = env['urlDatabase'];
  UrlFirebase.urlAuth = env['urlAuth'];
  UrlFirebase.apiKey = env['apiKey'];
  Application.productsUrl = '${UrlFirebase.urlDatabase}/products';
  Application.ordersUrl = '${UrlFirebase.urlDatabase}/orders';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ///O ideal é provider de autenticação ser o primeiro,
        ///pois outros providers precisam desse dado e eles
        ///são instanciados de forma hierárquica aqui, o 
        ///primeiro é instanciado primeiro. Até porquê agora 
        ///iremos usar um [ChangeNotifierProxyProvider] que irá
        ///ser atualizado segundo o provider de [Auth], então
        ///se ele não existir na hora que for atualizar irá 
        ///dar erro
        ChangeNotifierProvider(
          create: (_) => Auth()
        ),
        ///Para podermos receber o token via parâmetro e que 
        ///será provido pelo [Auth] após o usuário fazer login,
        ///precisamos trocar o [ChangeNotifierProvider] pelo 
        ///[ChangeNotifierProxyProvider], e então esse novo 
        ///Widget não terá o atributo update
        ///que é uma função que recebe 3 parâmetros, o 
        ///contexto, o primeiro item do generics que no caso é 
        ///o provider que irá fornecer o dado que precisamos, nesse
        ///caso, o [Auth], e o segundo generics é o terceiro parâmetro
        ///da função que recebe o update e que é o próprio provider mas
        ///antes de atualizar, no caso, os [Products] antigos. Na hora
        ///que for atualizar, o provider é criado de novo, por isso 
        ///precisamos receber os produtos na versão anterior, para não
        ///perder os dados que já tinham. Esse Widget também 
        ///deve receber o atributo create que funciona de forma
        ///igual aos [ChangeNotifierProvider]. No caso pegamos
        ///um provider só que precisávamos nesse que é o de 
        ///[Auth] e o próprio provider anterior, que é o de 
        ///[Products]. Se precisasse de mais Providers, aí
        ///teríamos que usar o [ChangeNotifierProxyProvider2] 
        ///por exemplo para poder usar 2 providers que no caso
        ///seria de [Auth] ou mais algum se fosse necessário, 
        ///mas como não é o caso o [ChangeNotifierProvider] já
        ///atende
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(
            null,
            []
          ),
          update: (_, auth, previousProducts) => Products(
            auth.token, previousProducts.items
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart()
        ),
        ChangeNotifierProvider(
          create: (_) => Orders()
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
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
        },
        navigatorKey: Application.navKey,
      ),
    );
  }
}