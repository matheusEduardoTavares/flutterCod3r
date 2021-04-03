import 'package:flutter/material.dart';
import 'package:shop/application/application.dart';
import 'package:shop/data/store.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/utils/custom_page_transition_builder.dart';
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
  await DotEnv.load(fileName: ".env");
  await Store.initStore();

  UrlFirebase.urlDatabase = env['urlDatabase'];
  UrlFirebase.urlAuth = env['urlAuth'];
  UrlFirebase.apiKey = env['apiKey'];
  Application.productsUrl = '${UrlFirebase.urlDatabase}/userFavorites';
  Application.ordersUrl = '${UrlFirebase.urlDatabase}/orders';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth()
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, previousProducts) => Products(
            auth.token, 
            auth.userId,
            previousProducts.items
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart()
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, previousOrders) => Orders(
            auth.token, 
            auth.userId,
            previousOrders.items,
          )
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }
          ),
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