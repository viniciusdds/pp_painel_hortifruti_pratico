import 'package:app_painel_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_profile_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/perfil/perfil_repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/perfil/widget/delete_perfil_image_widget.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {

  final PerfilRepository _repository;
  PerfilController(this._repository);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final currentImage = RxnString();
  // Define uma variável reativa do tipo booleano
  final isOnline = false.obs;
  final loading = false.obs;
  final image = Rxn<PlatformFile>();
  final _authService = Get.find<AuthService>();
  bool get isLogged => _authService.isLogged;

  @override
  void onInit() {
    //ever(_authService.user, (_) => fetchUser());

    fetchUser();
    super.onInit();
  }

  void fetchUser(){
    loading(true);
    _repository.getUser().then((data){
      nameController.text = data.name;
      emailController.text = data.email;
      isOnline.value = data.online == 1 ? true : false;
      currentImage.value = data.logo;

      //change(data, status: RxStatus.success());
      loading(false);
    }, onError: (error) {
      // change(null, status: RxStatus.error(error));
      loading(false);
    });
  }

  // Método para alternar o valor da variável
  void toggleSwitch(bool value) {
     isOnline.value = value;
  }

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.dashboard);
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
    var userModel = UserModel(
      name: nameController.text,
      email: emailController.text,
      logo: currentImage.value
    );


     var result = await Get.dialog(DeletePerfilImageWidget(userModel));

    if(result is bool && result == true){
      currentImage.value = '';

      print('Imagem do produto deletada');
    }
  }

  void submit(){
    Get.focusScope!.unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

    var userModel = UserModelRequest(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      online: isOnline.value == true ? 1 : 0,
      logo: image.value
    );

    _repository.updatePerfil(userModel).then((value){
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          const SnackBar(content: Text('Seu perfil foi atualizado.'))
      );

      passwordController.text = '';
    }, onError: (error) => Get.dialog(
        AlertDialog(title: Text(error.toString()))
    ));
  }

}