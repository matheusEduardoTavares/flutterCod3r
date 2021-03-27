import 'package:flutter/material.dart';
import 'package:shop/application/application.dart';
import 'package:shop/utils/url_firebase.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'package:shop/views/product_form_screen.dart';
import 'package:shop/views/products_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';
import './views/products_overview_screen.dart';
import './utils/app_routes.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import 'views/orders_screen.dart';

Future<void> main() async {
  ///Agora que está sendo trabalhado com o package 
  ///[DotEnv] - https://pub.dev/packages/flutter_dotenv
  ///basta criar na pasta raíz (fora de lib) o arquivo
  ///exatamente com nome [.env], e adicionar o conteúdo:
  ///urlFirebase='[URL PARA ACESSO AO FIREBASE]'

  await DotEnv.load(fileName: ".env");

  UrlFirebase.urlFirebase = env['urlFirebase'];
  Application.productsUrl = '${UrlFirebase.urlFirebase}/products';

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
        )
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