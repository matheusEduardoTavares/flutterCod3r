import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({
    Key key
  }) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;
  var _isLoadingProducts = true;

  @override 
  void initState() {
    super.initState();

    Provider.of<Products>(context, listen: false).loadProducts()
      .then((_) => setState(() {_isLoadingProducts = false;}));
    
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        centerTitle: true,
        actions: <Widget> [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorite) {
                setState(() {
                  _showFavoriteOnly = true;
                });
              }
              else {
                setState(() {
                  _showFavoriteOnly = false;
                });
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
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CART
                );
              },
            ),
            builder: (context, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          )
        ]
      ),
      body: _isLoadingProducts ? 
        Center(
          child: CircularProgressIndicator(),
        ) : ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer()
    );
  }
}