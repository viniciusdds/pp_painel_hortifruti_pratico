import 'package:app_painel_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/widgets/order/order_controller.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController with StateMixin<List<OrderModel>> {

  final OrderListRepository _repository;
  OrderListController(this._repository);

  final orderSelected = RxnString();

  @override
  void onInit() {
    _repository.getOrders().then((data) {
      var status = data.isEmpty ? RxStatus.empty() : RxStatus.success();
      change(data, status: status);
    }, onError: (error) {
      print(error.toString());
      change(null, status: RxStatus.error(error.toString()));
    });

    super.onInit();
  }

  void changeOrder(OrderModel order)  {
    //print("HASH1: ${order.hashId}");
    orderSelected.value = order.hashId;
    Get.find<OrderController>(tag: 'detail').orderId.value = order.hashId;
  }
}