import 'package:app_painel_hortifruti_pratico/app/modules/perfil/widget/delete_perfil_image_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeletePerfilImageController extends GetxController {

  final DeletePerfilImageRepository _repository;
  DeletePerfilImageController(this._repository);

  final loading = false.obs;

  void onSubmit(){
    // loading(true);
    //
    // _repository.deletePerfilImage(product.value!.id).then((_) async {
    //   Get.back(result: true);
    // }, onError: (error){
    //   Get.dialog(AlertDialog(title: Text(error.toString())));
    // })
    //     .whenComplete(() => loading(false));
  }

}