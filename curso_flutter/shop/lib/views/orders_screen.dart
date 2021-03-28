import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import '../widgets/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  Future<void> _getOrders(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).loadOrders();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos')
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _getOrders(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.error != null) {
            return Center(
              child: Text('Ocorreu um erro inesperado'),
            );
          }
          else {
            return Consumer<Orders>(
              builder: (ctx, orders, _) => RefreshIndicator(
                onRefresh: () async {
                  try {
                    await _getOrders(context);
                  }
                  catch (e) {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (_, __, ___) => AlertDialog(
                        title: Text('Erro'),
                        content: Text('Erro ao tentar atualizar os pedidos'),
                        actions: [
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop()
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) => OrderWidget(orders.items[index]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}