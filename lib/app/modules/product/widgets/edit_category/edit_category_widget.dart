import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/edit_category/edit_category_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/edit_category/edit_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditCategoryWidget extends StatelessWidget {

  int categoryId;
  String nameCategory;

  EditCategoryWidget({required this.categoryId, required this.nameCategory, super.key});

  final controller = Get.put(EditCategoryController(EditCategoryRepository(Get.find<Api>())));

  @override
  Widget build(BuildContext context) {

    controller.nameController.text = nameCategory;

    return AlertDialog(
      title: Text('Editar Categoria'),
      scrollable: true,
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              validator: (String? value){
                 if(value != null && value.isEmpty){
                   return 'Informe o nome da categoria';
                 }

                 return null;
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: Text('Fechar')
        ),
        TextButton(
            onPressed: controller.loading.isTrue ? null : () => controller.onSubmit(categoryId),
            child: Text('Editar')
        ),
      ],
    );
  }
}