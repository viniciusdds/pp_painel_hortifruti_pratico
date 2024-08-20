import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/edit_category/edit_category_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/edit_category/edit_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemSelectedCallback = void Function(CategoryModel category);

class CategoryListWidget extends StatelessWidget {
  final CategoryListController controller = Get.find();
  final ItemSelectedCallback onItemSelected;

  CategoryListWidget(this.onItemSelected, {super.key});

  @override
  Widget build(BuildContext context) {

    return controller.obx(
          (state) => ListView(
        children: [
          for (var category in state!)
            Obx(() => ListTile(
                title: Text(category.name),
                onTap: () => onItemSelected(category),
                selected: controller.categorySelected.value == category.id,
                trailing: PopupMenuButton<String>(
                  onSelected: (value){
                     if(value == 'edit'){
                         Get.dialog(EditCategoryWidget(
                           categoryId: controller.categorySelected.value == null
                               ? category.id
                               : controller.categorySelected.value!,
                           nameCategory: category.name,
                         ));
                     }else{
                         Get.dialog(
                           AlertDialog(
                             title: Text(
                                'Deseja remover a categoria ${category.name}?',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                             ),
                             scrollable: true,
                             actions: [
                               TextButton(
                                   onPressed: () => Get.back(),
                                   child: Text('Cancelar')
                               ),
                               TextButton(
                                   onPressed: () => controller.removeCategory(category.id),
                                   child: Text('Confirmar')
                               ),
                             ],
                           )
                         );
                     }
                  },
                itemBuilder: (BuildContext context){
                     return [
                       PopupMenuItem<String>(
                         value: 'edit',
                         child: Text('Editar'),
                       ),
                       PopupMenuItem<String>(
                         value: 'delete',
                         child: Text('Apagar'),
                       ),
                     ];
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ),
            )
        ],
      ),
    );
  }
}
