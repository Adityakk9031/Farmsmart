class Farmer {
  final String name;
  final String location;
  final List<String> products;

  Farmer({required this.name, required this.location, required this.products});
}

class Category {
  final String name;
  final List<Farmer> farmers;

  Category({required this.name, required this.farmers});
}
