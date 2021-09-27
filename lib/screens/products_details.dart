import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    final product =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Image.network(product.imageUrl, fit: BoxFit.contain),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 10, left: 10),
              margin: EdgeInsets.all(8),
              child: Text(product.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(8),
                  child: Text(product.description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.clip,
                      )),
                ),
                Container(
                  child: Text(
                    '\$ ' + product.price.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
