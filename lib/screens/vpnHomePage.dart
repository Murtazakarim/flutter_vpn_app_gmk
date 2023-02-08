
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:openvpn_flutter_update/openvpn_flutter.dart';
import 'package:vpn/appStyle/appColors.dart';
import 'package:vpn/controller/vpnHomePageController.dart';
import 'package:vpn/routes/routesName.dart';
import 'package:vpn/screens/serversScreen.dart';
import 'package:vpn/widgets/DrawerWidget.dart';
class VpnHomePage extends StatelessWidget {
   VpnHomePage({super.key});
  VpnHomePageController con = Get.put(VpnHomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.vpnKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: (){
              con.vpnKey.currentState?.openDrawer();
            },
            child: Image.asset('assets/img/menu_left_icon.png',width: 24,height: 24,)),
         title: const Text(
           "Unlimited Vpn",
           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16,fontFamily: 'DMSans'),
         ),
        centerTitle: true,
      ),

      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      body: SafeArea(
        child: Obx(()=>ModalProgressHUD(
          inAsyncCall: con.progress.value,
          progressIndicator: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: AppColors.colorLightGreen,),
                  SizedBox(height: 10,),
                  Text('Fetching servers',style: TextStyle(fontSize: 14,color: Colors.black),),
                  SizedBox(height: 5,),
                  Text('configurations',style: TextStyle(fontSize: 14,color: Colors.black),)
                ],
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: con.stage.value == VPNStage.connected ? 3 :2,
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Status",
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey1,fontFamily: 'DMSans'),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              con.stage.value == VPNStage.connected ? "Connected": "Disconnected",
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.colorLightGreen, fontSize: 18),
                            )
                          ],
                        ),),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text(
                              "Your IP",
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey1),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              con.isConnected.value ? con.vpnData[0][1].toString() : con.ipv4.value,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.colorLightGreen, fontSize: 18),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              if(con.stage.value == VPNStage.connected)
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Connection time",
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey1),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        '${con.status.value.duration}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
               Expanded(
                flex: 7,
                child:   Center(
                child: AvatarGlow(
                  glowColor: AppColors.colorLightGreen,
                  endRadius: 150,
                  repeat: true,
                 animate: con.animate.value,
                 showTwoGlows: true,
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(color: con.isConnected.value ? AppColors.colorLightGreen:AppColors.colorDarkGreen, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap:con.startVpn,
                        child: Container(
                          decoration:  BoxDecoration(
                            color: con.isConnected.value ? AppColors.colorLightGreen:AppColors.colorDarkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                              size: 94,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),),
              Expanded(
                flex: 2,
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Get.to(()=>ServerScreen(callBack: (){
                      },));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.colorBtn,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                      child: Row(
                        children: [
                          Image.asset('icons/flags/png/${con.vpnData.isNotEmpty ? con.vpnData[0][6].toString().toLowerCase(): 'us'}.png', package: 'country_icons',height: 20,
                            width: 25,
                            fit: BoxFit.fill,),
                          const SizedBox(width: 16),
                          Text(
                            con.vpnData.isNotEmpty ? con.vpnData[0][5].toString(): 'United State',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if(con.stage.value == VPNStage.connected)
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Upload",
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey1),
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: Colors.red.shade700,
                                size: 16,
                              ),
                              const SizedBox(width: 5,),
                              Text(
                                "${con.status.value.byteOut?.replaceAll('↑', '')}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Download",
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey1),
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children:  [
                              Icon(Icons.arrow_downward, color: Colors.blue.shade600,size: 16,),
                              const SizedBox(width: 5,),
                              Text(
                                "${con.status.value.byteIn?.replaceAll('↓', '')}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),),
      ),
    );
  }
}
