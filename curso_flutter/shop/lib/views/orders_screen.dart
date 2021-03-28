import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import '../widgets/order_widget.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = true;

  @override 
  void initState() {
    super.initState();

    Provider.of<Orders>(context, listen: false).
      loadOrders().then((_) => setState(() {
        _isLoading = false;
      }));
  }

  @override 
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos')
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : 
        RefreshIndicator(
          onRefresh: () async {
            try {
              await orders.loadOrders();
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
            itemBuilder: (ctx, index) => OrderWidget(orders.items[index])
          ),
      )
    );
  }
}