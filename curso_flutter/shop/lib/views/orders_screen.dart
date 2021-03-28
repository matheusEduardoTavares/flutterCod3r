import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import '../widgets/order_widget.dart';

///Outra estratégia para termos widgets que necessitam requisitar
///algo para o servidor, é deixar eles como [StatelessWidget] e
///usar o Widget [FutureBuilder].

/*
///Estratégia com o [StatefulWidget]:
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
      ),
    );
  }
}
*/

///Estratégia com o [FutureBuilder]:
class OrdersScreen extends StatelessWidget {
  Future<void> _getOrders(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).loadOrders();
  }

  @override 
  Widget build(BuildContext context) {
    ///Usando a estratégia do [FutureBuilder] não irá funcionar
    ///termos o nosso [Provider] fornecendo dados no método 
    ///[build] do widget. Aí usaremos por exemplo o [Consumer]
    ///para isso
    // final Orders orders = Provider.of(context);

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