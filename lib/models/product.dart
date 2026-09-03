class Product {
  Product({required this.name, required this.price, required this.category});

  String name;
  int price;
  Category category;
}

enum Category { food, hygiene, homeCleaning, homeServices, transport, others }
