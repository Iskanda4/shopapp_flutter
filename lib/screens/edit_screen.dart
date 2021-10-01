import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please fill following Field';
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
                          imageUrl: editedProduct.imageUrl);
                    },
                  ),
                  TextFormField(
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
                          imageUrl: editedProduct.imageUrl);
                    },
                  ),
                  TextFormField(
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
                          imageUrl: editedProduct.imageUrl);
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
                            border: Border.all(width: 1, color: Colors.grey)),
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
                          decoration: InputDecoration(labelText: 'Image URL'),
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
                                imageUrl: value);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: saveForm,
                        child: Text('Add Item'),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
