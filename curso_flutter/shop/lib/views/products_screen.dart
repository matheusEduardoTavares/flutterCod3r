import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/application/application.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/product_item.dart';
import '../widgets/app_drawer.dart';

class ProductsScreen extends StatelessWidget {

  ///Assim:
  // Future<void> _refreshProducts(BuildContext context) async {
  //   await Provider.of<Products>(context, listen: false).loadProducts();
  // }
  ///Ou:
  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<Products>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return Scaffold(
      key: Application.managerProductsScaffold,
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            }
          )
        ]
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshProducts(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.itemsCount,
            itemBuilder: (ctx, index) => Column(
              children: [
                ProductItem(
                  products[index]
                ),
                Divider()
              ],
            ) 
          )
        ),
      )
    );
  }
}