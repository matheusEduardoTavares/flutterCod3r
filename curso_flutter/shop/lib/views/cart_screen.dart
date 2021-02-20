import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho')
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20)
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline6.color
                      )
                    ),
                    backgroundColor: Theme.of(context).primaryColor
                  ),
                  ///Ao colocar o widget Spacer, podemos ocupar
                  ///, todo resto do espaço ou da row ou da coluna
                  ///assim conseguimos nesse caso fazer os 2 primeiros
                  ///itens da Row ficarem juntos, haver um espaço devido
                  ///o spaceBetween que será todo o espaço ocupado pelo
                  ///Spacer e aí ter o botão de comprar
                  Spacer(),
                  FlatButton(
                    child: Text('COMPRAR'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      /*
                      ///Passando os 2 parâmetros para o [addOrder]
                      Provider.of<Orders>(context, listen: false)
                        .addOrder(cartItems, cart.totalAmount);
                      */

                      ///Passando apenas o [cart] para o [addOrder]
                      Provider.of<Orders>(context, listen: false)
                        .addOrder(cart);

                      cart.clear();
                    },
                  )
                ],
              )
            )
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, index) => CartItemWidget(cartItems[index])
            )
          )
        ],
      )
    );
  }
}