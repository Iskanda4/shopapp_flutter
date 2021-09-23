import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/products_details.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetails.routeName, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black26,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.orangeAccent,
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_bag),
            color: Colors.orangeAccent,
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
