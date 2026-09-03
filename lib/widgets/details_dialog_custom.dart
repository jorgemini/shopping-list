import 'package:flutter/material.dart';
import 'package:shopping_list/models/product.dart';

class DetailsDialogCustom extends StatefulWidget {
  const DetailsDialogCustom({super.key, required this.products});

  final List<Product> products;

  @override
  State<DetailsDialogCustom> createState() => _DetailsDialogCustomState();
}

class _DetailsDialogCustomState extends State<DetailsDialogCustom> {
  int _totalByCategory(Category category) {
    int total = 0;
    for (final product in widget.products) {
      if (product.category == category) {
        total += product.price;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final category in Category.values)
            Row(
              children: [
                Text(category.name),
                const Spacer(),
                Text(
                  '\$${(_totalByCategory(category) / 100).toStringAsFixed(2)}',
                ),
              ],
            ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Leave'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
