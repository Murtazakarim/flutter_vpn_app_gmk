import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_flutter_update/openvpn_flutter.dart';
import 'package:vpn/widgets/CardServer.dart';
import '../controller/vpnHomePageController.dart';

class ServerScreen extends StatelessWidget {
  Function? callBack;
  ServerScreen({Key? key, this.callBack}) : super(key: key);
  VpnHomePageController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 25,
              )),
        ),
        title: const Text(
          'Servers',
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView.builder(
            itemCount: con.rowsAsListOfValues.length,
            itemBuilder: (BuildContext ctxt, int index) {
              if (index == 0 || index ==con.rowsAsListOfValues.length -1) {
                return const SizedBox();
              }
              return InkWell(
                  onTap: () async {
                    if (con.vpnData.isNotEmpty) {
                      if(await con.engine.isConnected()){
                        con.engine.disconnect();
                        Future.delayed(const Duration(seconds: 500));
                      }
                      con.stage.value = VPNStage.disconnected;
                        con.animate.value =true;
                      con.vpnData.clear();
                      con.vpnData.add(con.rowsAsListOfValues[index]);
                      con.update();
                      con.initPlatformState();
                      Future.delayed(const Duration(seconds: 500));
                      if (kDebugMode) {
                        print(con.rowsAsListOfValues[index]);
                      }

                      Get.back();
                    }
                  },
                  child: CardServer(
                      countryName: con.rowsAsListOfValues[index][5],
                      countryCode: con.rowsAsListOfValues[index][6],));
            }),
      ),
    );
  }
}


