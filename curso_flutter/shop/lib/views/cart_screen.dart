import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);

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
                      'R\$${cart.totalAmount}',
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
                    onPressed: () {},
                    child: Text('COMPRAR'),
                    textColor: Theme.of(context).primaryColor
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }
}