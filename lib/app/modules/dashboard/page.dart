import 'package:app_painel_hortifruti_pratico/app/modules/category_list/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/dashboard/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/home/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/user_profile/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetResponsiveView<DashboardController> {

  @override
  Widget desktop(){
    return Scaffold(
      body: Obx(() => Row(
          children: [
            NavigationRail(
                onDestinationSelected: controller.changePageIndex,
                selectedIndex: controller.currentPageIndex.value,
                labelType: NavigationRailLabelType.all,
                leading: const FlutterLogo(
                  size: 40,
                  style: FlutterLogoStyle.stacked,
                ),
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore),
                      label: Text("Início")
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.view_list_outlined),
                      selectedIcon: Icon(Icons.view_list),
                      label: Text("Produtos")
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.person_2_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: Text("Configurar")
                  )
                ],
            ),
            Expanded(child: _body())
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return Scaffold(
        bottomNavigationBar: Obx(
              () => NavigationBar(
            onDestinationSelected: controller.changePageIndex,
            selectedIndex: controller.currentPageIndex.value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Início',
                selectedIcon: Icon(Icons.explore),
              ),
              NavigationDestination(
                icon: Icon(Icons.view_list_outlined),
                label: 'Produtos',
                selectedIcon: Icon(Icons.view_list),
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                label: 'Configurar',
                selectedIcon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: Obx(
           () => _body()
        )
    );
  }

  IndexedStack _body() {
    return  IndexedStack(
              index: controller.currentPageIndex.value,
              children: [
                OrderListPage(),
                CategoryListPage(),
                UserProfilePage(),

              ],
            );
  }
}