import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final ProductRepository _repository;
  ProductController(this._repository);

  final product = Rxn<ProductModel>();
  final nameController = TextEditingController();
  final descricaoController = TextEditingController();
  final priceController = TextEditingController();

  final image = Rxn<PlatformFile>();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();

  @override
  void onInit() {
   //product.value = Get.arguments['product'];
    loadCategories();

    super.onInit();
  }

  Future<void> loadCategories() async {
    await _repository.getCategories().then((data){
      categoryList.assignAll(data);
    });
  }

  void changeCategory(int? categorySelected){
    categoryId.value = categorySelected;
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true
    );

    if(result != null && result.files.isNotEmpty){
      image.value = result.files.first;
    }
  }

  void onAdd(){

  }

}