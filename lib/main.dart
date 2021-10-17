import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_screen.dart';
import 'package:flutter_complete_guide/screens/products_details.dart';
import 'package:flutter_complete_guide/screens/products_overview.dart';
import 'package:flutter_complete_guide/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, prevProducts) => Products(auth.token,
                prevProducts == null ? [] : prevProducts.items, auth.userId),
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
              update: (ctx, auth, prevOrders) => Orders(auth.token,
                  prevOrders == null ? [] : prevOrders.orders, auth.userId)),
          // Adding providers which can be accessed throughout the whole app
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: auth.isAuth
                ? ProductsOverview()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : AuthScreen()),
            routes: {
              ProductDetails.routeName: (ctx) => ProductDetails(),
              CartScreen.routeName: (ctx) => CartScreen(),
              EditScreen.routeName: (ctx) => EditScreen(),
            },
          ),
        ));
  }
}
