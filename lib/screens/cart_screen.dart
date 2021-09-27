import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final item = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(item[index].title),
            subtitle: Text(item[index].price.toString()),
            trailing: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all()),
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                    ),
                    iconSize: 15,
                  ),
                  Text(item[index].quantity.toString()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                    ),
                    iconSize: 15,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: cart.items.length,
      ),
    );
  }
}
