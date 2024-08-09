import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/widgets/category_list/category_list.dart';
import 'package:app_painel_hortifruti_pratico/app/widgets/order_detail/order_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListPage extends GetResponsiveView<CategoryListController> {

  @override
  Widget desktop() {
    return Scaffold(
        appBar: AppBar(title: const Text('Meus Produtos')),
        body: Row(
          children: [
            Flexible(
              flex: 2,
                child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400
                    ),
                    child: CategoryListWidget(controller.changeCategory)
                )
            ),
            Flexible(
              flex: 3,
              child: OrderDetailWidget(),
            )
          ],
        )
    );
  }

  @override
  Widget phone() {
    return Scaffold(
        appBar: AppBar(title: const Text('Meus Produtos')),
        body: CategoryListWidget((category) => ()
           //(order) => Get.toNamed(
             //  Routes.order.replaceFirst(':id', order.hashId)
          // )
        )
    );
  }
}