import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/products_details.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () {
        return Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: data.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: 10,
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Column(
              children: [
                Image.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text('\$' + data.price.toString(),
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          data.setFav();
                        },
                        splashColor: Colors.blue,
                        splashRadius: 25,
                        icon: Icon(data.isFav
                            ? Icons.favorite
                            : Icons.favorite_outline),
                        color: Colors.lightBlueAccent),
                    IconButton(
                        onPressed: () {
                          cart.addItem(data.id, data.price, data.title);
                        },
                        icon: Icon(cart.isItemAdded(data.id)
                            ? Icons.shopping_bag
                            : Icons.shopping_bag_outlined),
                        color: Colors.lightBlueAccent)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
