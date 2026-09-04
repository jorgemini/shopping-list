import 'package:flutter/material.dart';
import 'package:shopping_list/models/product.dart';

class ProductListViewCustom extends StatelessWidget {
  const ProductListViewCustom({
    super.key,
    required this.products,
    required this.deleteProduct,
    required this.changeStatus,
  });

  final List<Product> products;
  final Function(int id) deleteProduct;
  final Function(Product product) changeStatus;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ListTile(
          title: Text(product.name),
          subtitle: Text(
            '\$${(product.price / 100).toStringAsFixed(2)} • ${product.category.name}',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteProduct(product.id!),
              ),
              IconButton(
                icon: Icon(
                  product.status == Status.purchased
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                ),
                onPressed: () => changeStatus(product),
              ),
            ],
          ),
        );
      },
    );
  }
}
