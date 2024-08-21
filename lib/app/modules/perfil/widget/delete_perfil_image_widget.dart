import 'package:app_painel_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/perfil/widget/delete_perfil_image_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/perfil/widget/delete_perfil_image_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeletePerfilImageWidget extends StatelessWidget {

  UserModel dados;

  DeletePerfilImageWidget(this.dados);

  @override
  Widget build(BuildContext context){
    final controller = Get.put(DeletePerfilImageController(DeletePerfilImageRepository(Get.find<Api>())));

    return AlertDialog(
      title: Text('Deseja excluir a imagem do logo'),
      actions: [
        TextButton(
            onPressed: Get.back,
            child: Text('Cancelar')
        ),
        Obx(() => TextButton(
            onPressed: controller.loading.isTrue ? null : () => controller.onSubmit(),
            child: Text('Excluir')
        )
        )
      ],
    );
  }

}