import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/edit_category/edit_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: 'Legumes');
  final loading = false.obs;

  final EditCategoryRepository _repository;
  EditCategoryController(this._repository);

  void onSubmit(int id){
    Get.focusScope!.unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

  var categoryRequest = CategoryRequestModel(
    id: id,
    name: nameController.text
  );

   loading(true);

   print("${nameController.text} - ${id}");

   _repository
    .putCategory(categoryRequest)
    .then((category) async {
      final productController = Get.find<ProductController>();
      await productController.loadCategories();
      productController.changeCategory(category.id);

      final categoryListController = Get.find<CategoryListController>();
      await categoryListController.loadOrders();

      Get.back();
   }, onError: (error){
      Get.dialog(AlertDialog(title: Text(error.toString())));
   })
   .whenComplete(() => loading(false));
  }
}