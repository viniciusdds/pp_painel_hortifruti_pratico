import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product_request.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/delete_product_image/delete_product_image_widget.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/new_category/new_category_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final ProductRepository _repository;
  ProductController(this._repository);

  final CurrencyTextInputFormatter priceFormatter = CurrencyTextInputFormatter(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2
  );

  final formKey = GlobalKey<FormState>();
  final product = Rxn<ProductModel>();
  final nameController = TextEditingController();
  final descricaoController = TextEditingController();
  final priceController = TextEditingController();

  final unitOfMeasure = RxString('UN');
  final image = Rxn<PlatformFile>();
  final currentImage = RxnString();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();
  final loading = false.obs;
  final editing = false.obs;
  late String title;

  @override
  void onInit() {
    loadCategories();

    if(Get.arguments != null){
      product.value = Get.arguments['product'];
      title = product.value!.name;
      editing(true);

      nameController.text = product.value!.name;
      descricaoController.text = product.value!.description ?? '';
      priceController.text = priceFormatter.format(product.value!.price.toString());
      unitOfMeasure.value = product.value!.unitOfMeasure;
      categoryId.value = product.value!.categoryId;
      currentImage.value = product.value!.image;

    }else if(Get.parameters['categoryId'] != null && Get.parameters['categoryId']!.isNotEmpty){
      print(Get.parameters['categoryId']!);
      categoryId.value = int.parse(Get.parameters['categoryId']!);
      title = 'Novo Produto';
    }else{
      title = 'Novo Produto';
    }

    //loadCategories();
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
      print(image.value);
    }
  }
  
  void onDeleteImage() async {
    var result = await Get.dialog(DeleteProductImageWidget(), arguments: product.value);

    if(result is bool && result == true){
      currentImage.value = '';

      print('Imagem do produto deletada');
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
      price:  priceFormatter.getUnformattedValue().toString(),
      unitOfMeasure: unitOfMeasure.value,
      categoryId: categoryId.value!,
      image: image.value
    );

    print("Add ${image.value}");

    loading(true);

    _repository.postProduct(productRequest).then((product) async {
      Get.back();
    }, onError: (error){
      Get.dialog(AlertDialog(title: Text(error.toString())));
    }).whenComplete(() => loading(false));
  }

  void onUpdate(){
    Get.focusScope!.unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

    var productRequest = ProductRequestModel(
        id: product.value!.id,
        name: nameController.text,
        description: descricaoController.text,
        price: priceFormatter.getUnformattedValue().toString(),
        unitOfMeasure: unitOfMeasure.value,
        categoryId: categoryId.value!,
        image: image.value
    );

    loading(true);

    _repository.putProduct(productRequest).then((product) async {
      Get.back();
      print('product updated');
    }, onError: (error){
      Get.dialog(AlertDialog(title: Text(error.toString())));
    }).whenComplete(() => loading(false));
  }

  void goToNewCategory(){
    Get.dialog(NewCategoryWidget());
  }

}