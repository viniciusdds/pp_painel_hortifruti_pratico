import 'package:app_painel_hortifruti_pratico/app/core/theme/app_theme.dart';
import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/storage/service.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/pages.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

void main() async {

  await GetStorage.init();
  Get.put<StorageService>(StorageService());
  Get.put<Api>(Api());
  Get.put<AuthService>(AuthService(AuthRepository(Get.find<Api>())));
  Get.put<CartService>(CartService());

  Intl.defaultLocale = 'pt_BR';

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.dashboard,
        theme: themeData,
        getPages: AppPages.pages,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [
          Locale('pt', 'BR')
        ],
      )
  );
}