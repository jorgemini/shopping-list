import 'package:flutter/material.dart';
import 'package:shopping_list/models/product.dart';

class AddProductDialogCustom extends StatefulWidget {
  const AddProductDialogCustom({super.key, required this.addProduct});

  final Function(Product product) addProduct;

  @override
  State<AddProductDialogCustom> createState() => _AddProductDialogCustomState();
}

class _AddProductDialogCustomState extends State<AddProductDialogCustom> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the product name',
                labelText: 'Product name',
              ),
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter the product name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.addProduct(
                Product(name: _productNameController.text.trim()),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
