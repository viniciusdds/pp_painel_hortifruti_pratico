import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product_request.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/new_category/new_category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final ProductRepository _repository;
  ProductController(this._repository);

  final formKey = GlobalKey<FormState>();
  final product = Rxn<ProductModel>();
  final nameController = TextEditingController();
  final descricaoController = TextEditingController();
  final priceController = TextEditingController();

  final unitOfMeasure = RxString('UN');
  final image = Rxn<PlatformFile>();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();
  final loading = false.obs;

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

  void changeUnitOfMeasure(String? value){
    unitOfMeasure.value = value!;
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
    Get.focusScope!.unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

    var productRequest = ProductRequestModel(
      name: nameController.text,
      description: descricaoController.text,
      price: priceController.text,
      unitOfMeasure: unitOfMeasure.value,
      categoryId: categoryId.value!,
      image: image.value
    );

    loading(true);

    _repository.postProduct(productRequest).then((product) async {
      print('product added');
      Get.back();
    }, onError: (error){
      Get.dialog(AlertDialog(title: Text(error.toString())));
    }).whenComplete(() => loading(false));
  }

  void goToNewCategory(){
    Get.dialog(NewCategoryWidget());
  }

}