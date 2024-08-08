import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final _authService = Get.find<AuthService>();
  var emailController = TextEditingController(text: 'estabelecimento2@email.com');
  var passwordController = TextEditingController(text: '12345678');
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print("LoginController created with formKey: $formKey");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    print("LoginController disposed");
    super.onClose();
  }

  void login() {
    Get.focusScope!.unfocus();

    print("LoginController created with formKey: $formKey");

    if (!formKey.currentState!.validate()) {
      return;
    }

    var userLoginRequestModel = UserLoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );

    loading(true);

    _authService
        .login(userLoginRequestModel)
        .then((value) {
      Get.offNamed(Routes.dashboard);
       //Get.back();
    }, onError: (error) {
      Get.dialog(AlertDialog(title: Text(error.toString()),));
    })
    .whenComplete(() => loading(false));
  }
}