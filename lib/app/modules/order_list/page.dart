import 'package:app_painel_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/widgets/order_list/order_list.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListPage extends GetView<OrderListController> {

  @override
  Widget build(BuildContext context) {

    print(controller.state);

    return Scaffold(
        appBar: AppBar(title: const Text('Meus Pedidos')),
        body: OrderListWidget()
    );
  }
}