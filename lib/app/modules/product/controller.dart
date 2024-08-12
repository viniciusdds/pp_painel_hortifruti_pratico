import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final nameController = TextEditingController();
  final descricaoController = TextEditingController();
  final priceController = TextEditingController();
  final observationController = TextEditingController();
  final _cartService = Get.find<CartService>();

  @override
  void onInit() {
   //product.value = Get.arguments['product'];

    super.onInit();
  }

  void onAdd(){

  }

}