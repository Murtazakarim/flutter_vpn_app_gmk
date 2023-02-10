import 'package:get/get.dart';
import 'package:vpn/routes/routesName.dart';
import 'package:vpn/screens/serversScreen.dart';

import '../screens/vpnHomePage.dart';

appRoutes() => [
      GetPage(
        name: AppRoutes.initial,
        page: () => VpnHomePage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: AppRoutes.server,
        page: () => ServerScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
