import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_list.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.onRemove,
  }) : super(key: key);

  final Transaction transaction;
  final DeleteTransaction onRemove;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black
  ];

  Color _backgroundColor;

  @override 
  void initState(){
    super.initState();

    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 5
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text(NumberFormat.currency(symbol: 'R\$', decimalDigits: 2).format(widget.transaction.value))),
          )
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.transaction.date)
        ),
        trailing: MediaQuery.of(context).size.width > 480 ? 
          FlatButton.icon(
            onPressed: () => widget.onRemove(widget.transaction.id), 
            icon: const Icon(Icons.delete), 
            label: const Text('Excluir'),
            textColor: Theme.of(context).errorColor,
          ) : InkWell(
            onTap: () => widget.onRemove(widget.transaction.id),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).errorColor,
              ),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
      ),
    );
  }
}