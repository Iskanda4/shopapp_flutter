import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/products_details.dart';
import 'package:flutter_complete_guide/screens/products_overview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductsOverview(),
      routes: {
        ProductDetails.routeName: (ctx) => ProductDetails(),
      },
    );
  }
}
