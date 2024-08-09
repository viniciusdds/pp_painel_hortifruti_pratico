import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/widgets/order/order_controller.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController with StateMixin<List<CategoryModel>> {

  final CategoryListRepository _repository;
  CategoryListController(this._repository);

  final categorySelected = RxnInt();

  @override
  void onInit() {
    loadOrders();

    super.onInit();
  }

  Future<void> loadOrders() async {
    await _repository.getCategories().then((data) {
      var status = data.isEmpty ? RxStatus.empty() : RxStatus.success();
      change(data, status: status);
    }, onError: (error) {
      print(error.toString());
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void changeCategory(CategoryModel category)  {
    //print("HASH1: ${order.hashId}");
    // orderSelected.value = order.hashId;
    // Get.find<OrderController>(tag: 'detail').orderId.value = order.hashId;
  }
}