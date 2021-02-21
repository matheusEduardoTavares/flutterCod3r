import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget(this.order);

  final Order order;

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ///Aqui precisamos que ao clicar nesse ícone seja
              ///expandido um [Container] em baixo do [ListTile]
              ///mostrando os detalhes daquele pedido. Para fazer
              ///isso, podemos fazer da seguinte forma: Ter uma 
              ///variável que define um estado e a partir do 
              ///estado mostrar um [Container] em baixo ou não, 
              ///e podemos controlar isso diretamente no 
              ///componente, sem ter que usar o Provider para isso.
              ///Outra forma de fazer isso é usando um [GFAccordion],
              ///que é uma importação de uma lib [getwidget] que
              ///podemos fazer no flutter. Tem outra lib para isso
              ///também, o [expandable].
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              }
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: (widget.order.products.length * 25.0) + 10,
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Text(
                        '${product.quantity}x R\$ ${product.price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey
                        )
                      ),
                    ],
                  );
                }).toList(),
              )
            ),
        ],
      )
    );
  }
}