import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn/controller/vpnHomePageController.dart';
import 'package:vpn/routes/approutes.dart';
import 'package:vpn/routes/routesName.dart';

void main() {
  Get.put(VpnHomePageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Vpn',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: appRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'DMSans',
        backgroundColor: Colors.white,
      ),
    );
  }
}
