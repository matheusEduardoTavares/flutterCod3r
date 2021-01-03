import 'dart:math';
import 'dart:io';
import 'components/chart.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    Intl.defaultLocale = 'pt_BR';
    
    return MaterialApp(
      title: 'ExpensesApp',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ],
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black
        ),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //usaremos o método initState e o método dispose para 
  //registrar um listener que ficará responsável por 
  //escutar as transições de estado da nossa aplicação.
  //Precisaremos usar um recurso chamado mixin do dart,
  //que significa mistura, quando queremos reaproveitar
  //código sem querer usar herança, é como se pegássemos
  //aquele código e copiássemos ele na classe, mas não 
  //será por herança e sim por mixin. Usamos a palavra
  //reservada with para usar os mixins e copiaremos o 
  //código com o mixin da classe WidgetsBindingObserver

  @override 
  void initState(){
    super.initState();

    //O this referência está classe. Estamos adicionando
    //esta classe como um observer para ser notificada
    //quando houver um evento.
    WidgetsBinding.instance.addObserver(this);
  }

  //Esse método é chamado sempre que houver uma mudança 
  //no estado da aplicação. Mas para ele ser chamado
  //precisamos registrar essa classe _MyHomePageState para
  //ser um interessado, um observe para quando houver 
  //mudanças nesse estado ele ser notificado. É 
  //oque fizemos dentro do initState
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  //Esse é um bom uso do dispose, remover um observer 
  //quando o componente que contém ele é destruído.
  @override 
  void dispose(){
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions{
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime pickedDateTime) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: pickedDateTime
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) async {
    int deleteTransactionId = _transactions.indexOf(_transactions.where((transaction) => transaction.id == id).first);

    bool deleteTransaction = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir Transação'),
          content: Text('Realmente deseja excluir a transação \'${_transactions[deleteTransactionId].title}\' ?'),
          actions: [
            FlatButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text('EXCLUIR'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      }
    );

    if (deleteTransaction == null || deleteTransaction == false) return ;

    setState(() {
      _transactions.removeAt(deleteTransactionId);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: TransactionForm(onSubmit: _addTransaction),
        );
      }
    );
  }

  Widget _getIconButton({IconData icon, Function fn}) {
    return Platform.isIOS ? 
      GestureDetector(
        child: Icon(icon),
        onTap: fn,
      ) : IconButton(
        icon: Icon(icon),
        onPressed: fn,
      );
  }

  @override
  Widget build(BuildContext context) {
    // print('build() _MyHomePageState');
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          icon: _showChart ? iconList : iconChart,
          fn: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        icon: Platform.isIOS ? CupertinoIcons.add : Icons.add,
        fn: () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS ? 
      CupertinoNavigationBar(
        middle: Text('Despesas Pessoais'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        )
      ) : AppBar(
        title: Text(
          'Despesas Pessoais',
        ),
        centerTitle: true,
        actions: actions
      );

    final availableHeight = mediaQuery.size.height 
      - appBar.preferredSize.height - mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(_recentTransactions)
              ),
            if (!_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 1 : 0.7),
              child: TransactionList(
                _transactions, 
                _deleteTransaction,
              ),
            )
          ]
        ),
      )
    );

    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appBar,
      child: bodyPage,
    ) : Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}