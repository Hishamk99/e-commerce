class ProductModel {
  final String name;
  final String? price;
  final String? desc;
  final String? location;
  final String? category;
  final String? id;
  int? kQuantity;

  ProductModel(
      {this.kQuantity,
      this.id,
      required this.name,
      this.price,
       this.desc,
       this.location,
      this.category});
}
