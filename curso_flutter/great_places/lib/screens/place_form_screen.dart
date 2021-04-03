import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  TextEditingController _titleController;

  @override 
  void initState() {
    super.initState();

    _titleController = TextEditingController();
  }

  void _submitForm() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        ///Uma forma de deixar o botão no fim da tela e 
        ///o formulário no início é usar:
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ///Mas fazendo isso, se colocarmos um Widget entre
        ///o formulário e o botão ele ficará no centro, 
        ///pois no início estará o formulário, no fim o 
        ///botão, e como é [spaceBetween], ele acabará 
        ///ficando no centro. Outra forma de fazermos isso
        ///então é usando o [Spacer] ou fazendo um wrap 
        ///do [SingleChildScrollView] onde 
        ///está o formulário dentro com
        ///um [Expanded] para que ocupe toda área. Com
        ///a estratégia do [Expanded], todo Widget que
        ///for adicionado agora entre o formulário e o
        ///[RaisedButton] irá ficar no fim antes do 
        ///[RaisedButton] já que o formulário passará
        ///a ocupar todo o espaço restante da [Column]
        ///externa devido ao [Expanded]
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ///Poderíamos usar o [Form] com os 
                    ///[TextFormField] para fazer as validações
                    ///e etc como já vimos, mas por enquanto aqui
                    ///iremos fazer um formulário mais simples
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          // Spacer(),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            color: Theme.of(context).accentColor,
            onPressed: _submitForm,
            elevation: 0,
            ///Para fazer esse [RaisedButton.icon] 
            ///encostar no fim da tela de fato sem ter
            ///o pequeno espaço em branco que fica
            ///entre ele e os botõs para 
            ///voltar / minimizar / fechar o APP, 
            ///basta setar o [materialTapTargetSize]
            ///para [MaterialTapTargetSize.shrinkWrap],
            ///pois shrink significa encolher, e assim 
            ///esse paddingzinho que era dado é tirado e
            ///assim o botão encosta na parte de baixo
            ///do device
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  @override 
  void dispose() {
    _titleController?.dispose();

    super.dispose();
  }
}