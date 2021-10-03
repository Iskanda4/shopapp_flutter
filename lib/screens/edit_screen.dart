import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edititem';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final imageUrlController = TextEditingController();
  final form = GlobalKey<FormState>();
  var editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  var isLoading = false;

  @override
  void dispose() {
    imageUrlController.dispose();
    super.dispose();
  }

  void saveForm() {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }
    form.currentState.save();
    setState(() {
      isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .addProduct(editedProduct)
        .catchError((error) {
      return showDialog<Null>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Adding Item Failed!'),
              content: Text('an error occured while attempting to add item'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            );
          });
    }).then((_) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  void saveEdits(String id) {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }
    form.currentState.save();
    Provider.of<Products>(context, listen: false)
        .updateProduct(id, editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    if (productId != null) {
      final product = Provider.of<Products>(context).findById(productId);
      editedProduct = product;
      imageUrlController.text = product.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(productId != null ? 'Edit Product Info' : 'Add Product'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: editedProduct.title,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please fill the field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Product Title',
                          ),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            editedProduct = Product(
                                id: editedProduct.id,
                                title: value,
                                description: editedProduct.description,
                                price: editedProduct.price,
                                imageUrl: editedProduct.imageUrl,
                                isFav: editedProduct.isFav);
                          },
                        ),
                        TextFormField(
                          initialValue: editedProduct.price > 0
                              ? editedProduct.price.toString()
                              : '',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please fill the field';
                            } else if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            } else if (double.parse(value) <= 0) {
                              return 'Please enter a number greater than zero';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Product Price',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            editedProduct = Product(
                                id: editedProduct.id,
                                title: editedProduct.title,
                                description: editedProduct.description,
                                price: double.parse(value),
                                imageUrl: editedProduct.imageUrl,
                                isFav: editedProduct.isFav);
                          },
                        ),
                        TextFormField(
                          initialValue: editedProduct.description,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please fill the field';
                            } else if (value.length < 10) {
                              return 'Description should be at least 10 characters long';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            editedProduct = Product(
                                id: editedProduct.id,
                                title: editedProduct.title,
                                description: value,
                                price: editedProduct.price,
                                imageUrl: editedProduct.imageUrl,
                                isFav: editedProduct.isFav);
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: imageUrlController.text.isEmpty
                                  ? Text(
                                      'Enter a URL',
                                      textAlign: TextAlign.center,
                                    )
                                  : Image.network(
                                      imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter an Image Url!';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: imageUrlController,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) {
                                  saveForm();
                                },
                                onSaved: (value) {
                                  editedProduct = Product(
                                      id: editedProduct.id,
                                      title: editedProduct.title,
                                      description: editedProduct.description,
                                      price: editedProduct.price,
                                      imageUrl: value,
                                      isFav: editedProduct.isFav);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: productId != null
                                  ? () => saveEdits(productId)
                                  : saveForm,
                              child: Text(productId != null
                                  ? 'Save Changes'
                                  : 'Add Item'),
                            ))
                      ],
                    ),
                  )),
            ),
    );
  }
}
