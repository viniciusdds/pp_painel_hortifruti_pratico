import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/delete_product_image/delete_product_image_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgets/delete_product_image/delete_product_image_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProductImageWidget extends StatelessWidget {
  DeleteProductImageWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    final controller = Get.put(DeleteProductImageController(DeleteProductImageRepository(Get.find<Api>())));

    return AlertDialog(
      title: Text('Deseja excluir a imagem do produto'),
      actions: [
        TextButton(
            onPressed: Get.back, 
            child: Text('Cancelar')
        ),
        Obx(() => TextButton(
              onPressed: controller.loading.isTrue ? null : controller.onSubmit,
              child: Text('Excluir')
           )
        )
      ],
    );
  }
  
}