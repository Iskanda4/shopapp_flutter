import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavOnly;

  ProductsGrid(this.showFavOnly);

  @override
  Widget build(BuildContext context) {
    final Productsdata = Provider.of<Products>(context);
    final products = showFavOnly ? Productsdata.favItems : Productsdata.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (2 / 3),
            crossAxisSpacing: MediaQuery.of(context).size.aspectRatio / 0.5,
            mainAxisSpacing: MediaQuery.of(context).size.aspectRatio / 0.4),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(), // ????
          );
        });
  }
}
