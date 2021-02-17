import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget(this.cartItem);

  final CartItem cartItem;

  @override 
  Widget build(BuildContext context) {
    return Dismissible(
      ///O dismissible é required o campo [key]
      key: ValueKey(cartItem.id),
      ///O background é o que aparece enquanto o 
      ///elemento está sendo arrastado
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        )
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).
          removeItem(cartItem.productId);
      },
      child: Card(
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
      ),
    );
  }
}