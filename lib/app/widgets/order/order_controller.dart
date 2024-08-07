import 'package:app_painel_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order/repository.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<OrderModel> {

  final OrderRepository _repository;
  OrderController(this._repository);
  final orderId = RxnString();

  @override
  void onInit() {
    String? id = Get.parameters['id'];

    ever(orderId, (String? id) => loadOrder());

    if (id != null) {
      orderId.value = id;
    }
    
    super.onInit();
  }

  Future<void> loadOrder() async {
    String id = orderId.value!;
    change(state, status: RxStatus.loading());

    await _repository.getOrder(id).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}