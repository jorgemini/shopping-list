class Product {
  Product({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.status,
  });

  int? id;
  String name;
  int price;
  Category category;
  Status status;

  // Convert Product to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category.name,
      'status': status.name,
    };
  }

  // Create Product from Map (from database)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      category: Category.values.byName(map['category']),
      status: Status.values.byName(map['status']),
    );
  }

  // For debugging
  @override
  String toString() {
    return 'Product(id: $id, name: $name, category: $price)';
  }
}

enum Category { food, hygiene, homeCleaning, homeServices, transport, others }

enum Status { purchased, noPurchased }
