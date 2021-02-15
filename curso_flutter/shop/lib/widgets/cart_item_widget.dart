import 'package:flutter/material.dart';
import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget(this.cartItem);

  final CartItem cartItem;

  @override 
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        ///O listTile já tem as posições pré-definidas, deixando fácil
        ///definir os itens para por na lista
        child: ListTile(
          title: Text(cartItem.title),
          subtitle: Text('Total: R\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
          trailing: Text('${cartItem.quantity}x'),
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('${cartItem.price.toStringAsFixed(2)}')
              )
            )
          )
        )
      )
    );
  }
}