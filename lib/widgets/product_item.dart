import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/products_details.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: id);
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
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline),
                        color: Colors.lightBlueAccent),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_bag_outlined),
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
