import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';

class OrderProductModel {

  ProductModel product;
  String quantity;
  String value;
  String? observation;

  OrderProductModel({
    required this.product,
    required this.quantity,
    required this.value,
    this.observation,
  });

  num get total => double.parse(value) * double.parse(quantity);

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => OrderProductModel(
    product: ProductModel.fromJson(json['produto']),
    quantity: json['quantidade'],
    value: json['valor'],
    observation: json['observacao'],
  );
}