import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//Pacote de internacionalização que importamos no 
//pubspec.yaml para poder padronizar a formatação da
//data:
import 'package:intl/intl.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    //Definindo o locale default antes de inserir os 
    //localizationsDelegates. Com esse locale default
    //não é preciso passar pt_BR na hora de fazer a 
    //formatação pois esse já será o default.

    Intl.defaultLocale = 'pt_BR';
    
    return MaterialApp(
      title: 'ExpensesApp',
      //Importamos no pubspec.yaml o flutter_localizations
      //assim:
      //   flutter_localizations:
      //      sdk: flutter
      //importamos aqui esse pacote para termos acesso ao
      //GlobalMaterialLocalizations e ao 
      //GlobalWidgetsLocalizations
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ],
      theme: ThemeData(
        //o primaryColor recebe uma cor como parâmetro
        //e o primarySwatch recebe um MaterialColor como
        //parâmetro. O MaterialColor é uma lista de 
        //cores dentro de um mesmo espectro de cores. Temos
        //um range de colors dentro dele, já no primaryColor
        //é apenas uma cor, já o primarySwatch recebe um 
        //conjunto de cores, e dependendo do componente 
        //quando ele for exibido pode ser que ele pegue a 
        //cor intermediária desse primarySwatch que seria
        //o 500, ou alguma outra.
        primarySwatch: Colors.purple,
        //O Colors.purple é um MaterialColor, assim passamos
        //não apenhas o roxo puro como todo o espectro de
        //cores roxa, desde o 50 até o 900
        //Só de deixar definido o primarySwatch, a cor da
        //appBar e do floatingActionButton já mudam 
        //automaticamente, enquanto as cores dos containers
        //para cada item das listas de transação continuam 
        //com outras cores pois atributos específicos são 
        //mais relevantes que os genéricos, e as cores do 
        //tema são genéricos, então nesses containers como 
        //já tem cores definidas lá, é de lá que as cores 
        //serão pegas. Alguns componentes quando não tem 
        //cores definidas pode ser que usem a cor padrão ao
        //invés de pegar alguma cor do tema, e nesse caso 
        //é só passar a cor como Theme.of(context).[atributo]
        //sendo o [atributo] qual atributo no tema definimos
        //que tem a cor que queremos, nesse caso seria:
        //Theme.of(context).primaryColor , de forma que mesmo
        //que não setamos a primaryColor será pego a cor 
        //definida na primarySwatch,
        //Iremos setar também a cor de realce, o accentColor
        //, no caso do accentColor não temos um Swatch para
        //ele. Só de definir o accentColor, antes o FAB estava
        //com a cor do primarySwatch, e agora passa a usar a 
        //cor do accentColor. O accentColor recebe uma cor
        //e como o Colors.amber é um MaterialColor, será 
        //pego a cor padrão desse MaterialColor que é 
        //500, então o resultado de Colors.amber é o mesmo
        //de colocar Colors.amber[500] . Porém já foi 
        //depreciado o uso do accentColor para definir as 
        //cores do FAB, no caso do FAB precisamos passar o
        //atributo floatingActionButtonTheme que recebe um 
        //FloatingActionButtonThemeData e a partir deste 
        //ThemeData ir preenchendo suas cores específicas.
        accentColor: Colors.amber,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black
        ),
        //Depois de criar a pasta assets e a pasta fonts
        //dentro da pasta assets e jogar as fontes dentro
        //da pasta fonts, fizemos a importação das fontes
        //no pubspec.yaml, e então a usamos aqui passando
        //o nome da família da fonte igualzinho como 
        //colocamos no pubspec, pois se passar uma fonte 
        //que não for entendida será pego a padrão.
        fontFamily: 'Quicksand',
        //Podemos definir as fontes específicas para dados
        //widgets:
        appBarTheme: AppBarTheme(
          //O ThemeData.light() já traz o tema default do
          //flutter, então pegamos o textTheme dele e para
          //mudar uma única propriedade, o copiamos com 
          //copyWith e alteramos a propriedade que queremos.
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              //Mesmo resultado para os 2 FontWeight :
              fontWeight: FontWeight.w700 // FontWeight.bold
            )
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            //Mesmo resultado para os 2 FontWeight :
            fontWeight: FontWeight.w700 // FontWeight.bold
          )
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
  //Não é indicado ter variáveis que não sejam final 
  //dentro de um componente stateless.

  //Mesmo marcando a variável como final, ainda sim 
  //iremos precisar alterar o estado interno dessa
  //variável, e não é bom mesmo que temos um atributo 
  //final mas que dentro deste atributo, é uma classe que
  //os estados internos dessa classe vão estar alterando,
  //o ideal ainda assim é colocar dentro de um componente
  //stateful;
  // final _titleController = TextEditingController();
  // final _valueController = TextEditingController();


  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    //O Navigator é um widget do tipo Stateful e tem um
    //método estático chamado of e recebe um context como
    //parâmetro. Esse é um padrão muito comum quando temos
    //os widgets que são herdados, o InheritedWidget, temos
    //3 tipos de widgets:
    //stateless, stateful, inherited
    //O InheritedWidget é usado quando precisamos passar 
    //dados de um componente na árvore que está longe de 
    //outro, eles conseguem se comunicar sem precisar
    //percorrer cada componente um a um na árvore, ele 
    //consegue fazer um túnel e acessar direto independente
    //de como está a hierarquia, diferente do stateless e
    //do stateful que precisam percorrer componente a 
    //componente para poder passar informação para outro
    //componente mais distante da árvore. O Navigator na
    //verdade é uma exceção pois ele herda de 
    //StatefulWidget, mas veremos isso mais à frente.
    //Para fechar a tela então basta executar 
    //Navigator.of(context).pop(); , de forma que a 
    //navegação no flutter é baseada em pilha então 
    //para esconder o modal quando submitar o formulário
    //basta fechar pois o modal é adicionado na pilha, 
    //foi o último a entrar nela, então quando damos um 
    //pop é ele quem sai (pilha = LIFO).
    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(BuildContext context) {
    //A função showModalBottomSheet serve para abrir um
    //modal na parte inferior da tela. É parecido com o 
    //showDialog
    showModalBottomSheet(
      context: context,
      //O context do builder é um context que será passado
      //como parâmetro da função, não é o mesmo context
      //que estamos recebendo por parâmetro.
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
          //Podemos definir a fonte de um texto específico:
          // style: TextStyle(fontFamily: 'OpenSans')
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      //Usando o SingleChildScrollView irá funcionar de 
      //forma a fazer scroll e não quebrar quando o tamanho
      //da altura é sobreposto. Isso só funciona aqui pois
      //essa coluna tem um pai com tamanho pré-definido,
      //no caso o body do Scaffold tem um tamanho pré-
      //definido e por isso funciona.
      body: SingleChildScrollView(
        child: Column(
          //A coluna coloca como default o alinhamento do
          //eixo X como centro, então podemos mudar isso caso
          //queremos que comece no início:
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Para fazer o card ocupar todo espaço horizontal
            //da tela, podemos fazer um wrap dele em um 
            //Container e definir o width do container como
            //double.infinity, ou melhor ainda, é só fazer
            //a column ter CrossAxisAlignment.stretch .
            Container(
              child: Card(
                color: Colors.blue,
                child: Text('Gráfico'),
                //O elevation serve para dar uma noção de 
                //de 3D para destacar aquele (eixo z)
                //card, aumentando o sombreamento o quanto
                //maior for o valor do elevation (double)
                elevation: 5
              ),
            ),
            TransactionList(_transactions)
            // Column(
              // children: <Widget>[
                //Exemplo de Comunicação indireta entre 
                //Widgets:
                // TransactionForm(onSubmit: widget.addTransaction,),
                //Exemplo de Comunicação direta entre 
                //Widgets:
                // TransactionList(_transactions),
              // ],
            // )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      //Posição do FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}