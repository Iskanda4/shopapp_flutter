import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/product_item.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';
import 'package:provider/provider.dart';

// In this class we used the Products.dart provider in order to apply
// the filter logic for Fav Items which works just fine but this filter will
// be applied to the application globally whenever we wanna show those items
// So Its BETTER if we manage this state locally in the widget itself by
// turning it to a stateful widget, managing the showfav boolean and pass it
// down to the widget displaying the items
// The Commented Parts is the old method used
enum FilterOptions { Favorites, All }

class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool ShowFavOnly = false;

  @override
  Widget build(BuildContext context) {
    // final productsController = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions value) {
                setState(() {
                  if (value == FilterOptions.Favorites) {
                    // productsController.ShowFav();
                    ShowFavOnly = true;
                  } else {
                    ShowFavOnly = false;
                    // productsController.ShowAll();
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites),
                PopupMenuItem(
                    child: Text('Show All'), value: FilterOptions.All),
              ],
            ),
          ],
        ),
        body: ProductsGrid(ShowFavOnly));
  }
}
