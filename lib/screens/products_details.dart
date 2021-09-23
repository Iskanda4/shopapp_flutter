import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
