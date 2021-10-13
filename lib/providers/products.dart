import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var showFavOnly = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFav).toList();
  }

  // void ShowFav() {
  //   showFavOnly = true;
  //   notifyListeners();
  // }

  // void ShowAll() {
  //   showFavOnly = false;
  //   notifyListeners();
  // }

  final String authToken;

  Products(this.authToken, this._items);

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://fluttershopapp-f1618-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final fetchedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      fetchedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFav: prodData['isFav']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://fluttershopapp-f1618-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFav': product.isFav
          }));

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  // This is another way to do the same thing as above
  // http
  //     .post(url,
  //         body: json.encode({
  //           'title': product.title,
  //           'description': product.description,
  //           'price': product.price,
  //           'imageUrl': product.imageUrl,
  //           'isFav': product.isFav
  //         }))
  //     .then((response) {
  //   final newProduct = Product(
  //       id: json.decode(response.body)['name'],
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl);
  //   _items.add(newProduct);
  //   notifyListeners();
  // }).catchError((error) {
  //   print(error);
  //   throw error;
  // });

  void updateProduct(String id, Product newProduct) async {
    int index = _items.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final url = Uri.parse(
          'https://fluttershopapp-f1618-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken');
      http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
    }
    _items[index] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://fluttershopapp-f1618-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Product couldnt be deleted!');
    }
    existingProduct = null;
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
