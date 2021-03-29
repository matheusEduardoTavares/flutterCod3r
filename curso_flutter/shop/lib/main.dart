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
        ChangeNotifierProvider(
          create: (_) => Products()
        ),
        ChangeNotifierProvider(
          create: (_) => Cart()
        ),
        ChangeNotifierProvider(
          create: (_) => Orders()
        ),
        ChangeNotifierProvider(
          create: (_) => Auth()
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