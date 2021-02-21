import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = showFavoriteOnly ? 
      productsProvider.favoriteItems : 
      productsProvider.items;

    if (products.isEmpty)
      return Center(
        child: Text(
          'Não há nenhum item favoritado !',
          style: TextStyle(
            fontSize: 38,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 0.5,
                color: Colors.red,
                offset: Offset(1, 1)
              ),
              Shadow(
                blurRadius: 0.5,
                color: Colors.black,
                offset: Offset(1.5, 1.5)
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
    );
  }
}