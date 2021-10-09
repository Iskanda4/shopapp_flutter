import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/widgets/order_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).FetchOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  // error handling stuff
                  return Center(
                    child: Text('Error Occured!'),
                  );
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, orderData, _) => ListView.builder(
                            itemBuilder: (ctx, index) {
                              return OrderWidget(orderData.orders[index]);
                            },
                            itemCount: orderData.orders.length,
                          ));
                }
              }
            }));
  }
}
