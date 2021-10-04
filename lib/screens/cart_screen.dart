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
                confirmDismiss: (direction) {
                  return showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text('Remove Item'),
                          content: Text(
                              'Are you sure you want to remove this item from the cart?'),
                          actions: [
                            FlatButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                }),
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        );
                      });
                },
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
                  CheckoutButton(cart: cart)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
        label: isLoading
            ? CircularProgressIndicator()
            : Text(
                'Proceed to Checkout',
                style: TextStyle(color: Colors.white),
              ),
        onPressed: (widget.cart.itemCount <= 0 || isLoading)
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.totalAmount);
                setState(() {
                  isLoading = false;
                });
                widget.cart.clearCart();
              },
        backgroundColor: Colors.blue,
        elevation: 5);
  }
}
