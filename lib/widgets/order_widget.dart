import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final OrderItem order;

  OrderWidget(this.order);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            ListTile(
              title: Text('Order No# ' + widget.order.id),
              subtitle: Text(
                DateFormat.yMMMd().format(widget.order.dateTime),
              ),
              trailing: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Amount: \$' + widget.order.amount.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            expanded = !expanded;
                          });
                        },
                        icon: Icon(
                            expanded ? Icons.expand_less : Icons.expand_more)),
                  ],
                ),
              ),
            ),
            if (expanded)
              Container(
                height: min(widget.order.products.length * 10.0 + 100, 150),
                child: ListView.builder(
                    itemBuilder: (ctx, index) => Row(
                          children: [
                            Card(
                              child: Container(
                                height: 50,
                                width: 360,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(widget
                                              .order.products[index].quantity
                                              .toString() +
                                          'x ' +
                                          widget.order.products[index].title),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text('\$ ' +
                                          widget.order.products[index].price
                                              .toString()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    itemCount: widget.order.products.length),
              )
          ],
        ));
  }
}
