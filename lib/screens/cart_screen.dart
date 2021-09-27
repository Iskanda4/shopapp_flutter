import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(15),
            itemBuilder: (ctx, index) {
              return Dismissible(
                key: ValueKey(item[index].id),
                background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 30)),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  cart.removeItem(item[index].id);
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(item[index].title),
                    subtitle: Text("\$" + item[index].price.toString()),
                    trailing: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all()),
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              cart.removeQuantity(
                                  item[index].id, item[index].quantity);
                            },
                            icon: Icon(
                              Icons.remove,
                            ),
                            iconSize: 15,
                          ),
                          Text(item[index].quantity.toString()),
                          IconButton(
                            onPressed: () {
                              cart.addQuantity(item[index].id);
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                            iconSize: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: cart.items.length,
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: 100,
            width: double.infinity,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total: \$' + cart.totalAmount,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InputChip(
                      label: Text(
                        'Proceed to Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clearCart();
                      },
                      backgroundColor: Colors.blue,
                      elevation: 5)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
