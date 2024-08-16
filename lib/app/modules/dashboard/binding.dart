import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/dashboard/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/repository.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<CategoryListController>(() => CategoryListController(CategoryListRepository(Get.find<Api>())));
    Get.lazyPut<OrderListController>(() => OrderListController(OrderListRepository(Get.find<Api>())));
    Get.lazyPut<ProductController>(() => ProductController(ProductRepository(Get.find<Api>())));
  }
}