import 'dart:math';
import 'components/chart.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'package:flutter/material.dart';
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
        GlobalWidgetsLocalizations.delegate
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

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

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
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    //Conseguimos pegar medidas relativas ao tamanho
    //da tela usando o método of, passando o context
    //como parâmetro, para o MediaQuery. Esse context
    //serve para passar as informações necessárias para
    //saber qual a localização do widget na árvore, 
    //diz então qual é o componente que é renderizado, 
    //e há uma relação entre o componente pai e um 
    //componente filho em que um contexto do filho consegue
    //acessar um componente pai e assim acessar os elementos
    //da árvore de componentes. A partir disso temos vários
    //atributos e métodos disponíveis por esse Media
    //Query.of(context). , como por exemplo o método 
    //devicePixelRatio que mostra a densidade de pixel de
    //um dispositivo; desabilitar a animação com o 
    //disableAnimations; padding, e etc. Mas o que nos 
    //importa é o size.

    //No caso da altura, temos que considerar  
    //outros fatores e não só o percentual do 
    //tamanho da tela, então se colocarmos 30% do
    //tamanho da tela para o Chart e 70% para o 
    //TransactionList, não irá pegar 100% da tela
    //igual imaginamos, irá passar desse tamanho.
    //Sempre que trabalhar com a altura, caso use
    //um scaffold devemos considerar o tamanho da
    //AppBar, e tem também a status bar para ser
    //considerada.

    //Ou seja, para sabermos o tamanho real que temos 
    //sobrando, precisamos pegar a altura do AppBar para
    //subtrair da altura da tela, e para fazer isso 
    //tiraremos o AppBar direto da estrutura e o colocaremos
    //em uma constante:

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        )
      ],
    );

    //Para acessar a altura da AppBar pegamos o height do
    //atributo preferredSize que pegamos por sua vez 
    //da constante contendo a AppBar.
    //Conseguimos acessar a altura do statusBar pelo 
    //MediaQuery.of(context).padding.top;
    final availableHeight = MediaQuery.of(context).size.height 
      - appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    //Com isso o availableHeight vai conter exatamente 
    //a altura que restou disponível, já que tiramos o 
    //tamanho do AppBar e do StatusBar.

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: availableHeight * 0.3,
              child: Chart(_recentTransactions)
            ),
            //Dá erro:
            // Expanded(
            //   child: TransactionList(
            //     _transactions, 
            //     _deleteTransaction,
            //   )
            // )
            Container(
              height: availableHeight * 0.7,
              child: TransactionList(
                _transactions, 
                _deleteTransaction,
              ),
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}