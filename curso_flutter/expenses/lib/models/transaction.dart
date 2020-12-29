import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  const Transaction({
    @required this.id,
    @required this.title,
    @required this.value,
    @required this.date
  });
}