import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  bool isItemAdded(String productId) {
    if (_items.containsKey(productId)) {
      return true;
    } else {
      return false;
    }
  }

  void addItem(String productId, double price, String title) {
    // if (_items.containsKey(productId)) {
    //   _items.update(
    //       productId,
    //       (value) => CartItem(
    //           id: value.id,
    //           title: value.title,
    //           price: value.price,
    //           quantity: value.quantity + 1));
    // } else {
    _items.putIfAbsent(productId,
        () => CartItem(id: productId, title: title, price: price, quantity: 1));
    // }
    notifyListeners();
  }

  void addQuantity(String productId) {
    _items.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity + 1));
    notifyListeners();
  }

  void removeQuantity(String productId, int quantity) {
    if (quantity > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  String get totalAmount {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total.toStringAsFixed(2);
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void RemoveSingleItem(String productKey) {
    if (_items.containsKey(productKey)) {
      if (_items[productKey].quantity > 1) {
        _items.update(
            productKey,
            (data) => CartItem(
                id: data.id,
                title: data.title,
                price: data.price,
                quantity: data.quantity - 1));
      } else {
        _items.remove(productKey);
      }
      notifyListeners();
    } else {
      return;
    }
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
