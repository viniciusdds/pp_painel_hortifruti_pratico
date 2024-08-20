import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:app_painel_hortifruti_pratico/app/widgets/category/category_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/widgets/category/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos da Categoria'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                print("Category: ${controller.categoryId.value.toString()}");
                Get.toNamed(
                  Routes.product,
                  parameters: {
                    'categoryId': controller.categoryId.value.toString(),
                  }
                );
              },
              icon: const Icon(Icons.add_rounded),
              tooltip: 'Adicionar Produto',
          )
        ],
      ),
      body: CategoryWidget()
    );
  }
}
