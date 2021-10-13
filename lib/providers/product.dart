import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav = false;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFav = false});

  Future<void> setFav(String token) async {
    final url = Uri.parse(
        'https://fluttershopapp-f1618-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token');
    final oldstatus = this.isFav;
    this.isFav = !this.isFav;
    notifyListeners();
    try {
      final response = await http.patch(url,
          body: json.encode({
            'title': title,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
            'isFav': isFav
          }));
      if (response.statusCode >= 400) {
        this.isFav = oldstatus;
        notifyListeners();
      }
    } catch (error) {
      this.isFav = oldstatus;
      notifyListeners();
      throw error;
    }
  }
}
