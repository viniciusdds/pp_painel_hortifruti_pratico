
import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:app_painel_hortifruti_pratico/app/widgets/category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryController controller;
  CategoryWidget({String? tag, super.key})
      : controller = Get.find<CategoryController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
       (state) => ListView(
         children: [
           for (var product in state!)
             ListTile(
               title: Text(product.name),
               subtitle: Text(NumberFormat.simpleCurrency().format(double.parse(product.price)) + (product.isKg ? '/kg' : '')),
               leading: product.image != null
                   ? SizedBox(
                 width: 56.0,
                 height: 56.0,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(8.0),
                   child: FadeInImage.memoryNetwork(
                     placeholder: kTransparentImage,
                     image: product.image!,
                   ),
                 ),
               )
                   : null,
               onTap: () {
                 Get.delete<ProductController>();
                 Get.toNamed(Routes.product, arguments: {'product': product});
               },

               // => Get.toNamed(
               //     Routes.product,
               //     arguments: {
               //       'product': product
               //     }
               // ),
             )
         ],
       ),
      onEmpty: const Center(
        child: Text('Nenhum produto cadastrado na categoria.'),
      )
    );
  }
}
