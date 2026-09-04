import 'package:flutter/material.dart';
import 'package:shopping_list/models/product.dart';
import 'package:shopping_list/widgets/add_product_dialog_custom.dart';
import 'package:shopping_list/widgets/product_list_view_custom.dart';
import 'package:shopping_list/widgets/details_dialog_custom.dart';
import 'package:shopping_list/core/database/database_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _refreshProductList();
  }

  Future<void> _refreshProductList() async {
    List<Product> products = await dbHelper.getAllProducts();
    setState(() {
      _products
        ..clear()
        ..addAll(products)
        ..sort((a, b) => a.category.index.compareTo(b.category.index));
    });
  }

  Future<void> _addProduct(Product product) async {
    await dbHelper.insertProduct(product);
    _refreshProductList();
  }

  void _deleteProduct(int id) async {
    await dbHelper.deleteProduct(id);
    _refreshProductList();
  }

  Future<void> _showAddProductDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddProductDialogCustom(addProduct: _addProduct);
      },
    );
  }

  int get _total {
    int total = 0;
    for (int i = 0; i < _products.length; i++) {
      total += _products[i].price;
    }
    return total;
  }

  Future<void> _showDetailsDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DetailsDialogCustom(products: _products);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _products.isEmpty
          ? Center(
              child: Text(
                'No products yet',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ProductListViewCustom(
                    products: _products,
                    deleteProduct: _deleteProduct,
                  ),
                ),
                TextButton(
                  child: Center(
                    child: Text(
                      'Total: \$${(_total / 100).toStringAsFixed(2)}\nClick to view details',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    _showDetailsDialog();
                  },
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
