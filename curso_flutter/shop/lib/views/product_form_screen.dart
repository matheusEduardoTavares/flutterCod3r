import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../providers/product.dart';

class ProductFormScreen extends StatefulWidget {

  const ProductFormScreen({
    this.isUrlImageFinishWithExtension = false
  });

  ///Se a URL de uma imagem não finaliza com uma dada extensão,
  ///então a imagem deve conter aquela URL.
  final bool isUrlImageFinishWithExtension;

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

  @override 
  void didChangeDependencies() {
    /// Método associado ao state que é 
    /// chamado sempre que o widget é alterado
    /// e a árvore é rebuildada, para notificar
    /// que houve mudanças

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context)
        .settings.arguments as Product;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'];
      }
    }

    super.didChangeDependencies();
  }

  void _updateImage() {
    if (_isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  /*
  bool isValidImageUrl(String url) {
    final pattern = RegExp('/\.jpg|.png|\jpeg/g');
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithAllTypes = pattern.hasMatch(url);
    return (startWithHttp || startWithHttps) && (endsWithAllTypes);
  }
  */

  bool _isValidImageUrl(String url) {
    var urlOnLowerCase = url.toLowerCase();
    bool startWithHttp = urlOnLowerCase.startsWith('http://');
    bool startWithHttps = urlOnLowerCase.startsWith('https://');
    bool endsWithPng;
    bool endsWithJpg;
    bool endsWithJpeg;

    if (widget.isUrlImageFinishWithExtension ?? false) {
      endsWithPng = urlOnLowerCase.endsWith('.png');
      endsWithJpg = urlOnLowerCase.endsWith('.jpg');
      endsWithJpeg = urlOnLowerCase.endsWith('.jpeg');
    }
    else {
      endsWithPng = urlOnLowerCase.contains('.png');
      endsWithJpg = urlOnLowerCase.contains('.jpg');
      endsWithJpeg = urlOnLowerCase.contains('.jpeg');
    }

    bool isValidProtocol = (startWithHttp || startWithHttps)
      && (endsWithPng || endsWithJpg || endsWithJpeg);

    return isValidProtocol;
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
      id: _formData['id'],
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl'],
    );

    ///Quando usamos o [Provider] fora do 
    ///método build, e esse [Provider] precisa
    ///ficar escutando as modificações, isso irá
    ///gerar um erro dizendo que tentamos usar um
    ///[Provider] fora da árvore de componentes.
    ///Só conseguiremos usar um [Provider] fora 
    ///do método build se marcarmos o seu 
    ///[listen] para false
    final products = Provider.of<Products>(context, listen: false);

    if (_formData['id'] == null) {
      products.addProduct(newProduct);
    }
    else {
      products.updateProduct(newProduct);
    }

    Navigator.of(context).pop();
  }

  // String _initialValueOrDefault(String Function() returnValue) {
  //   try {
  //     return returnValue();
  //   }
  //   catch (_) {
  //     return '';
  //   } 
  // }

  @override
  Widget build(BuildContext context) {
    // final Product product = ModalRoute.of(context)?.settings?.arguments;

    // _imageUrlController.text = _initialValueOrDefault(() => product.imageUrl);

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
                initialValue: _formData['title'],
                // initialValue: _initialValueOrDefault(() => product.title),
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
                    return 'Informe um título com no mínimo 3 caracteres!';
                  }

                  return null;
                }
              ),
              ///Hoje em dia já funciona ir para o próximo
              ///item mesmo sem usar o [FocusNode]
              TextFormField(
                initialValue: _formData['price']?.toString(),
                // initialValue: _initialValueOrDefault(() => product.price.toString()),
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
                },
                validator: (value) {
                  var isEmpty = value.trim().isEmpty;
                  var newPrice = double.tryParse(value);
                  var isInvalid = newPrice == null || newPrice <= 0.0;

                  if (isEmpty || isInvalid) {
                    return 'Informe um preço válido!';
                  }

                  return null;
                }
              ),
              TextFormField(
                initialValue: _formData['description'],
                // initialValue: _initialValueOrDefault(() => product.description),
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
                validator: (value) {
                  var isEmpty = value.trim().isEmpty;
                  var isInvalid = value.trim().length < 10;
                  if (isEmpty || isInvalid) {
                    return 'Informe uma descrição válida com no mínimo 10'
                    ' caracteres!';
                  }

                  return null;
                }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      ///Dá erro se usar o [initialValue] 
                      ///aqui porquê já usamos o controller.
                      ///Só mexemos no valor inicial se o 
                      ///[controller] não for passado
                      // initialValue: _formData['imageUrl'],
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
                      validator: (value) {
                        var isEmptyUrl = value.trim().isEmpty;
                        var isValidUrl = _isValidImageUrl(value);

                        if (isEmptyUrl || !isValidUrl) {
                          return 'Informe uma URL válida!';
                        }

                        return null;
                      }
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