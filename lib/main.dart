import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _products = [];

  void _addProduct() {
    setState(() {
      _products.add('Product ${_products.length + 1}');
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
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
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_products[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteProduct(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
