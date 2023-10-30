class ProductModel {
  final String name;
  final String price;
  final String desc;
  final String location;
  final String category;
  final String? id;
  int? kQuantity;

  ProductModel(
      {this.kQuantity,
      this.id,
      required this.name,
      required this.price,
      required this.desc,
      required this.location,
      required this.category});
}
