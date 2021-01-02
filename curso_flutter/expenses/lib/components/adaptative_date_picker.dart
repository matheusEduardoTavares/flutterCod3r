import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

typedef ShowDatePicker = void Function(DateTime);

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ShowDatePicker onDateChanged;

  const AdaptativeDatePicker({
    @required this.selectedDate,
    @required this.onDateChanged
  });

  _showDatePicker(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );

    onDateChanged(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? Container(
      height: 180,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        minimumDate: DateTime(2019),
        maximumDate: DateTime.now(),
        onDateTimeChanged: onDateChanged,
      ),
    ) : Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              selectedDate == null ? 'Nenhuma data selecionada!' :
              'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'
            ),
          ),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Selecionar Data', 
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            onPressed: () => _showDatePicker(context),
          )
        ],
      ),
    );
  }
}