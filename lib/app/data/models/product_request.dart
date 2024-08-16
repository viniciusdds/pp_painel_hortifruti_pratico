
import 'package:file_picker/file_picker.dart';

class ProductRequestModel {
  int? id;
  String name;
  String price;
  String unitOfMeasure;
  PlatformFile? image;
  int categoryId;
  String? description;

  bool get isKg => unitOfMeasure == 'KG';

  ProductRequestModel({
    this.id,
    required this.name,
    required this.price,
    required this.unitOfMeasure,
    this.image,
    required this.categoryId,
    this.description
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) => ProductRequestModel(
    id: json['id'],
    name: json['nome'],
    price: json['preco'],
    unitOfMeasure: json['unidade'],
    image: json['imagem'],
    categoryId: json['categoria_id'],
    description: json['descricao']
  );

  Map<String, dynamic> toJson() => {
    'nome': name,
    'descricao': description,
    'preco': price,
    'unidade': unitOfMeasure,
    'categoria_id': categoryId,
    "posicao": 1
  };
}