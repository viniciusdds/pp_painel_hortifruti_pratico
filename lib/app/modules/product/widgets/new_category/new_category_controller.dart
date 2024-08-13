import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/new_category/new_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryController extends GetxController {

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: 'Legumes');
  final loading = false.obs;

  final NewCategoryRepository _repository;
  NewCategoryController(this._repository);

  void onSumbmit(){
    Get.focusScope!.unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

  var categoryRequest = CategoryRequestModel(
    name: nameController.text
  );

   loading(true);

   _repository
    .postCategory(categoryRequest)
    .then((category) async {
      final productController = Get.find<ProductController>();
      await productController.loadCategories();
      productController.changeCategory(category.id);

      //final categoryListController = Get.find<CategoryListController>();
     // await categoryListController.loadCategories();

      Get.back();
   }, onError: (error){
      Get.dialog(AlertDialog(title: Text(error.toString())));
   })
   .whenComplete(() => loading(false));
  }
}