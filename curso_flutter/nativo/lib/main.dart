import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _a = 0;
  var _b = 0;
  var _sum = 0;

  Future<void> _calcSum() async {

    ///Importando o package:flutter/services.dart,
    ///temos acesso ao [MethodChannel], e com 
    ///ele usamos um método para se comunicar 
    ///com o nativo. O nome do channel que vamos
    ///criar tem uma certa padronização, em que 
    ///geralmente o nome do channel é aquilo que 
    ///deseja-se estabelecer de comunicação
    const channel = MethodChannel('cod3r.com.br/nativo');

    try {
      ///Uma vez pegando o canal para se estabelecer
      ///a comunicação com o nativo, a partir daquele
      ///dado canal, podemos chamar um método específico
      ///daquele channel, pois um mesmo channel pode 
      ///ter vários métodos. O segundo parâmetro que 
      ///passamos usando o método [invokeMethod] é 
      ///caso queiramos passar algum argumento 
      ///para o método lá no nativo
      final sum = await channel.invokeMethod(
        'calcSum',
        {
          'a': _a,
          'b': _b,
        }
      );

      setState(() {
        _sum = sum;
      });
    }
    on PlatformException {
      setState(() {
        _sum = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nativo"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soma... $_sum',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _a = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _b = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                child: Text('Somar'),
                onPressed: _calcSum,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
