import 'dart:math';
import 'dart:io';
// import 'package:flutter/services.dart';
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
    //Caso nossa aplicação deva funcionar obrigatoriamente
    //apenas em uma orientação, devemos usar uma classe
    //chamada SystemChrome, que importamos do pacote 
    //package:flutter/services.dart , e podemos setar 
    //as orientações que podem ser usadas passando para 
    //o método setPreferredOrientations uma lista de 
    //orientações. O método é da classe SystemChrome.
    //Com ele setado mesmo que esteja habilitado no 
    //device para fazer a rotação de tela e o usuário 
    //gire a tela do device, ele vai mudar e se manter 
    //apenas em orientações que permitirmos (que estão 
    //dentro desta lista).

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);

    //Nessa aplicação não usaremos isso, teremos que 
    //adaptar a aplicação para poder exibir certo em 
    //qualquer orientação.

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

  //Dará um erro no IOs dizendo que está tentando colocar o 
  //IconButton e ele não é um componente disponível no 
  //Cupertino, requer um Cupertino Widget. Então criaremos
  //um método para ajudar a criar um botão:
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
    //Uma pequena otimização para não ter que ficar 
    //criando sempre um novo MediaQuery.
    final mediaQuery = MediaQuery.of(context);

    //Verificando se o device está no modo paisagem:
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          icon: _showChart ? Icons.list : Icons.show_chart,
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

    //Todo appBar precisa ser um PreferredSizeWidget, e
    //aqui o iremos tipar para poder reaproveitar esse 
    //fazendo uma condicional no appBar pois no 
    //navigationBar do CupertinoScaffoldPage ele precisa
    //receber um CupertinoNavigationBar e no Scaffold 
    //precisa receber um AppBar. 
    //O title do AppBar é o middle do CupertinoNavigationBar
    final PreferredSizeWidget appBar = Platform.isIOS ? 
      CupertinoNavigationBar(
        middle: Text('Despesas Pessoais'),
        //Mas o CupertinoNavigationBar precisa ocupar o 
        //mínimo de espaço possível com a Row para o trailing
        //se não o middle será sobreposto e não aparecerá, 
        //por isso passamos para a Row ocupar o menor tamanho
        //do eixo X possível
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        )
      ) : AppBar(
        title: Text(
          'Despesas Pessoais',
          //Por default é 1 o MediaQuery.of(context).textScaleFactor, 
          //e seu valor pode aumentar de acordo com quanto o 
          //usuário setou em seu device na área de acessibilidade
          //os tamanhos das fontes.
          // style: TextStyle(
          //   fontSize: 20 * MediaQuery.of(context).textScaleFactor,
          // ),
        ),
        centerTitle: true,
        actions: actions
      );

    //Para acessar a altura da AppBar pegamos o height do
    //atributo preferredSize que pegamos por sua vez 
    //da constante contendo a AppBar.
    //Conseguimos acessar a altura do statusBar pelo 
    //MediaQuery.of(context).padding.top;
    final availableHeight = mediaQuery.size.height 
      - appBar.preferredSize.height - mediaQuery.padding.top;

    //Com isso o availableHeight vai conter exatamente 
    //a altura que restou disponível, já que tiramos o 
    //tamanho do AppBar e do StatusBar.

    final bodyPage = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Só exibiremos o switch (que é um toggle)
          //se ele estiver em modo paisagem
          /*
          //Substituído pelo novo ícone usado na AppBar
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Com o Widget Switch, podemos mostrar 
                //um widget ou outro
                //dependendo de uma condição, na verdade
                //ele dá um elemento que arrastamos um 
                //círculo em um slide para definir o 
                //true ou o false.
                Text('Exibir Gráfico'),
                //O Switch com seu construtor default 
                //terá o visual do android, para fazer 
                //um Switch com visual adaptado para o
                //IOs, devemos usar seu construtor 
                //adaptive. Assim ele irá se adaptar
                //de acordo com a plataforma. Usará
                //o padrão Material se estiver no 
                //android e usará o padrão do Cupertino
                //se estiver em um IOs.
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          */
          //Em modo paisagem não é possível ver bem 
          //as barras dos gráficos.
          //Na operação ternária conseguimos apenas 
          //mostrar um widget ou outro, já usando o 
          //if conseguimos montar expressões mais 
          //complexas, inclusive diferentes para cada
          //componente
          if (_showChart || !isLandscape)
          //Outro problema no momento é que quando 
          //estamos no modo paisagem o gráfico fica ruim
          //de enxergar, isso porque até então o seu 
          //tamanho era availableHeight * 0.3, e como 
          //no modo paisagem provavelmente a altura já
          //será um valor baixo, então usar 30% dessa 
          //altura ficava ruim para enxergar ainda. Então
          //teremos que verificar a orientação do 
          //dispositivo e caso ela seja paisagem definir 
          //um percentual maior. O appBar do scaffold é 
          //o navigationBar no Cupertino.
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
    );

    //Ao invés de simplesmente retornarmos o Scaffold, 
    //iremos agora retorná-lo apenas se for android, e se
    //for IOs iremos retornar o CupertinoPageScaffold, 
    //mas primeiro devemos importar:
    //import 'package:flutter/cupertino.dart';
    //É importante de ressaltar que há uma certa 
    //inconsistência nos nomes dos atributos. Enquanto
    //no CupertinoPageScaffold tems child, no Scaffold
    //temos body, mas é a mesma coisa, por isso 
    //iremos abstrair o body e adicionar em uma 
    //constante para poder reutilizar tanto no 
    //CupertinoPageScaffold quanto no Scaffold.
    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appBar,
      child: bodyPage,
    ) : Scaffold(
      appBar: appBar,
      body: bodyPage,
      //como o FAB não é um botão usado no padrão do 
      //IOs, iremos escondê-lo caso a plataforma seja
      //IOs. Importando o dart:io , temos acesso ao 
      //Platform e a partir dele podemos verificar se é
      //Android, IOs, entre outros.
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}