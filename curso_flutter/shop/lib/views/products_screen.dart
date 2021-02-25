import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product_item.dart';
import '../widgets/app_drawer.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {}
          )
        ]
      ),
      drawer: AppDrawer(),
      body: Padding(
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
      )
    );
  }
}