class ProductModel {

  int id;
  String name;
  num price;
  String unitOfMeasure;
  String? description;
  String? image;

  bool get isKg => unitOfMeasure == 'KG';

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.unitOfMeasure,
    this.image,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['nome'],
    price: json['preco'],
    unitOfMeasure: json['unidade'],
    image: json['imagem'] as String?,
    description: json['descricao'],
  );
}