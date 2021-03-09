import 'dart:math';
import 'package:flutter/material.dart';
import '../providers/product.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override 
  void initState() {
    super.initState();

    _imageUrlFocusNode.addListener(_updateImage);
  }

  void _updateImage() {
    setState(() {});
  }

  void _saveForm() {
    ///O método [validate] irá chamar todos os métodos [validator]
    ///que forem passados para cada um dos [FormField] dentro do 
    ///[Form], de forma que se um único retornar uma string, mostra
    ///que a validação deu erro e tal método retorna então false.
    var isValid = _formKey.currentState.validate();

    if(!isValid) {
      return;
    }

    ///Esse método save irá chamar o método [onSaved] de cada
    ///um dos campos [TextFormField] do formulário
    _formKey.currentState.save();

    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl'],
    );

    print(newProduct.title);
    print(newProduct.id);
    print(newProduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            }
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                onSaved: (value) => _formData['title'] = value,
                decoration: InputDecoration(
                  labelText: 'Título',
                  ///Podemos passar atributos para personalizar 
                  ///o erro do input
                ),
                ///Atributo que serve para definir qual
                ///será a ação do input. Ao usar o 
                ///[TextInputAction.next], ao invés do
                ///botão confirmar irá aparecer um botão
                ///escrito avançar, e assim, se houverem 
                ///mais [TextFormField] e for programado
                ///para ir para um próximo - é o dev quem
                ///programa isso através dos [FocusNode],
                ///então irá para o próximo input de acordo
                ///com o que foi definido no [FocusNode]. Se
                ///for o último input, apenas fecha o teclado.
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  ///Para ir para o próximo input do 
                  ///Focus:
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                ///A função [validator] é disparada ao 
                ///disparar a validação do formulário. Temos
                ///a possibilidade de usar o [autovalidate] como
                ///true, ou então através do método [validate()]
                ///que usamos a partir da chave global do 
                ///[FormState], acessando primeiro o atributo
                ///[currentState]. Caso retornemos [null] no 
                ///[validator], não há validação para ser feita,
                ///e caso retornemos uma string significa que há 
                ///um erro de validação
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Informe um título válido';
                  }

                  if (value.trim().length < 3) {
                    return 'Informe um título com no mínimo 3 letras!';
                  }

                  return null;
                }
              ),
              ///Hoje em dia já funciona ir para o próximo
              ///item mesmo sem usar o [FocusNode]
              TextFormField(
                onSaved: (value) => _formData['price'] = double.tryParse(value),
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                    .requestFocus(_descriptionFocusNode);
                }
              ),
              TextFormField(
                onSaved: (value) => _formData['description'] = value,
                decoration: InputDecoration(
                  labelText: 'Descrição'
                ),
                maxLines: 3,
                ///No caso do IOs, o [TextInputType.multiline]
                ///não terá o mesmo comportamento do android
                keyboardType: TextInputType.multiline,
                ///Ao tirar o [TextInputAction.next], agora
                ///ao clicar onde ficava o ícone de done ou
                ///de ir para o próximo, será pulado uma linha
                ///pois criamos um [TextFormField] com 3 linhas,
                ///e como sua ação não é de ir para um próximo
                ///[TextFormField], então apenas são pulados as 
                ///linhas desse campo já que é um campo marcado
                ///com [TextInputType.multiline]
                // textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      ///Não precisamos chamar o setState na hora de 
                      ///atribuir esses valores pois não precisamos alterar
                      ///a interface gráfica, e apenas alterar os valores
                      ///dentro do [formData], mas não precisa haver uma 
                      ///atualização na interface gráfica
                      onSaved: (value) => _formData['imageUrl'] = value,
                      decoration: InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      keyboardType: TextInputType.url,
                      ///Campo que a partir dele vamos 
                      ///submeter o formulário
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      left: 10
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      )
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty ? 
                      Text('Informe a URL') :
                        LayoutBuilder(
                          builder: (ctx, constraints) => Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            child: FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }

  @override 
  void dispose() {
    _priceFocusNode?.dispose();
    _descriptionFocusNode?.dispose();
    _imageUrlFocusNode?.removeListener(_updateImage);
    _imageUrlFocusNode?.dispose();

    super.dispose();
  }
}