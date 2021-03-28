import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../providers/product.dart';

class ProductFormScreen extends StatefulWidget {

  const ProductFormScreen({
    this.isUrlImageFinishWithExtension = false
  });

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
  var _isLoading = false;

  @override 
  void initState() {
    super.initState();

    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override 
  void didChangeDependencies() {
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

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState.validate();

    if(!isValid) {
      return;
    }

    _formKey.currentState.save();

    final newProduct = Product(
      id: _formData['id'],
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl'],
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Products>(context, listen: false);

    try {
      if (_formData['id'] == null) {
        await products.addProduct(newProduct);
      }
      else {
        await products.updateProduct(newProduct);
      }
      Navigator.of(context).pop();
    }
    catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro durante o salvamento do produto!'),
          actions: [
            FlatButton(
              child: Text('FECHAR'),
              onPressed: () => Navigator.of(context).pop()
            ),
          ],
        ),
      );
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
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
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['title'],
                onSaved: (value) => _formData['title'] = value,
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
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
              TextFormField(
                initialValue: _formData['price']?.toString(),
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
                onSaved: (value) => _formData['description'] = value,
                decoration: InputDecoration(
                  labelText: 'Descrição'
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
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
                      onSaved: (value) => _formData['imageUrl'] = value,
                      decoration: InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      keyboardType: TextInputType.url,
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