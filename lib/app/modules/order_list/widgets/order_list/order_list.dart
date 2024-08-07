import 'package:app_painel_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

typedef ItemSelectedCallback = void Function(OrderModel order);

class OrderListWidget extends StatelessWidget {
  final OrderListController controller = Get.find();
  final ItemSelectedCallback onItemSelected;

  OrderListWidget(this.onItemSelected, {super.key});

  @override
  Widget build(BuildContext context) {


    return controller.obx(
          (state) => ListView(
        children: [
          for (var order in state!)
            ListTile(
              title: Text('#${order.hashId}'),
              subtitle: Text(DateFormat("dd/MM/y HH:mm").format(order.createdAt)),
              trailing: Chip(label: Text(order.statusList.last.name)),
              onTap: () => onItemSelected(order),
            )
        ],
      ),
      onEmpty: const Center(
        child: Text(
          'Você não fez nenhum pedido ainda.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
