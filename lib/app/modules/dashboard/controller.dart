import 'package:app_painel_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  var currentPageIndex = 0.obs;

  @override
  void onInit() {
    int? index = Get.arguments;

    if (index != null) {
      currentPageIndex.value = index;
    }

    ever(Get.find<AuthService>().user, (user){
      if(user == null){
        Get.offAllNamed(Routes.login);
      }
    });

    super.onInit();
  }

  void changePageIndex(int index) {
    currentPageIndex.value = index;
  }
}