import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';

class CartProductModel {

  ProductModel product;
  String quantity;
  String? observation;

  CartProductModel({
    required this.product,
    required this.quantity,
    this.observation,
  });

  num get total => double.parse(product.price) * double.parse(quantity);

  Map<String, dynamic> toJson() => {
    'produto_id': product.id,
    'quantidade': quantity,
    if (observation != null && observation!.trim().isNotEmpty)
      'observacao': observation,
  };
}