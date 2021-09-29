import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/cart.dart';

class OrderItem {
  final String id;
  final String amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, String total) {
    _orders.insert(
        0,
        OrderItem(
            id: (_orders.length + 1).toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
