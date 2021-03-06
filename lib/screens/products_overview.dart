import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/screens/user_products.dart';
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
  int selectedPage = 0;
  bool isLoading = false;
  void handlePage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsController = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: (() {
        if (selectedPage == 0)
          return AppBar(title: Text('My Shop'), actions: [
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
            Consumer<Cart>(
              builder: (_, cart, _1) => Stack(children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                Text(
                  cart.itemCount.toString(),
                ),
              ]),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ]);
      }()),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (() {
              switch (selectedPage) {
                case 0:
                  return ProductsGrid(ShowFavOnly);
                  break;
                case 1:
                  return OrderScreen();
                  break;
                case 2:
                  return UserProductsScreen();
                  break;
              }
            }()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: 'Shop', icon: Icon(Icons.shop)),
          BottomNavigationBarItem(label: 'Orders', icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              label: 'Your Products', icon: Icon(Icons.edit)),
        ],
        currentIndex: selectedPage,
        onTap: handlePage,
      ),
    );
  }
}
