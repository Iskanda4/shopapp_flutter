import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_screen.dart';
import 'package:flutter_complete_guide/screens/products_details.dart';
import 'package:flutter_complete_guide/screens/products_overview.dart';
import 'package:provider/provider.dart';

import 'providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(
            create: (ctx) =>
                Orders()) // Adding 3 providers which can be accessed throughout the whole app
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ProductsOverview(),
        routes: {
          ProductDetails.routeName: (ctx) => ProductDetails(),
          CartScreen.routeName: (ctx) => CartScreen(),
          EditScreen.routeName: (ctx) => EditScreen(),
        },
      ),
    );
  }
}
