import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_screen.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    // final products = productData.userItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => refreshProducts(context),
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Consumer<Products>(
                          builder: (ctx, products, _) => ListView.builder(
                            itemBuilder: (ctx, index) {
                              return UserProductItem(
                                  products.userItems[index].id,
                                  products.userItems[index].title,
                                  products.userItems[index].imageUrl);
                            },
                            itemCount: products.userItems.length,
                          ),
                        )),
                  ),
      ),
    );
  }
}
