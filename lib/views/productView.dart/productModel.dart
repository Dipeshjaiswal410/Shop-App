// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String name;
  final String image;
  final double price;
  final double weight;
  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.weight,
  });

  // Convert ProductModel to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'price': price,
        'weight': weight,
      };

  // Convert JSON to ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      weight: json['weight'],
    );
  }
}

final List<ProductModel> productSamples = [
  ProductModel(
    name: "Rice",
    image: "",
    price: 1250,
    weight: 25,
  ),
  ProductModel(
    name: "Sugar",
    image: '',
    price: 120,
    weight: 1,
  ),
  ProductModel(
    name: "Meat",
    image: '',
    price: 1200,
    weight: 3,
  ),
  ProductModel(
    name: "Wood",
    image: '',
    price: 500,
    weight: 3,
  ),
  ProductModel(
    name: "Stone",
    image: '',
    price: 10000,
    weight: 100,
  ),
  ProductModel(
    name: "Cement",
    image: '',
    price: 605,
    weight: 50,
  ),
  ProductModel(
    name: "Rod",
    image: '',
    price: 14000,
    weight: 1000,
  ),
];
