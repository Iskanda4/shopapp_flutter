import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditScreen.routeName,
                      arguments: id,
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.blue)),
              IconButton(
                  onPressed: () {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(id)
                        .then((_) =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Product Deleted!',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(
                                milliseconds: 500,
                              ),
                            )))
                        .catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error.toString()),
                        duration: Duration(
                          milliseconds: 500,
                        ),
                      ));
                    });
                  },
                  icon: Icon(Icons.delete, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
