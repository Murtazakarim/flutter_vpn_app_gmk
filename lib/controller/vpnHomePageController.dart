import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:openvpn_flutter_update/openvpn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
String csvData ='';
List<dynamic> japan = [];
List<dynamic> russia = [];

class VpnHomePageController extends GetxController {
  Timer? connectionTimer;
  var timeText = "".obs;
  var timeCounter = 0.obs;
  var progress = false.obs;
  var isConnected = false.obs;
  late OpenVPN engine;
  var ipv4 =''.obs;
  var status = VpnStatus().obs;
  Rx<VPNStage> stage = Rx<VPNStage>(VPNStage.disconnected);
 // VPNStage? stage;
  List<List<dynamic>> rowsAsListOfValues = [];
  var vpnData = <dynamic>[].obs;
  var animate = false.obs;
  final GlobalKey<ScaffoldState> vpnKey = GlobalKey();


  @override
  void onInit() {
    super.onInit();
    getVpnDate();
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        status.value = data!;
      },
      onVpnStageChanged: (data, raw) {
        stage.value = data;
        if(stage.value == VPNStage.authenticating){
          animate.value = true;
        }else if (stage.value == VPNStage.connected) {
          animate.value = false;
          isConnected.value = true;
        }else if(stage.value == VPNStage.exiting){
          animate.value = false;
          Get.rawSnackbar(message: "Server Disconnected");
        }else {
          isConnected.value = false;
          timeText.value = "00:00";
        }
      },
    );

    engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier:
      "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) {
        this.stage.value = stage;
      },
      lastStatus: (status) {
        this.status.value = status;
      },
    );
  }

  Future<void> initPlatformState() async {
    String base64ToUtf8 = utf8.decode(base64.decode(vpnData[0][14]));
   String config =base64ToUtf8.replaceAll('cipher', 'data-ciphers');
    engine.connect(config, vpnData[0][5],
        username: '',
        password: '',
        certIsRequired: false);
  }

  startVpn() async{
    if(stage.value == VPNStage.connected){
      engine.disconnect();
      isConnected.value =false;
    }else{
    //  engine.disconnect();
      animate.value = true;
      initPlatformState();
    }
  }


  void getVpnDate()async{
    final prefs = await SharedPreferences.getInstance();
    ipv4.value = await Ipify.ipv4();
    String? value = prefs.getString('vpnData');
    if(value != null && value != ''){
      rowsAsListOfValues = const CsvToListConverter().convert(value);
      rowsAsListOfValues.removeAt(0);
      rowsAsListOfValues.removeAt(rowsAsListOfValues.length -1);
      vpnData.add(rowsAsListOfValues[1]);
      if (kDebugMode) {
        print(rowsAsListOfValues[1]);
      }
    }else{
      progress.value = true;
      var url = Uri.parse('https://www.vpngate.net/api/iphone');
      var response  = await http.get(url);
      if(response.statusCode == 200){
        String data  =response.body;
        prefs.setString('vpnData', data);
        rowsAsListOfValues = const CsvToListConverter().convert(data);
        rowsAsListOfValues.removeAt(0);
        rowsAsListOfValues.removeAt(rowsAsListOfValues.length -1);
        vpnData.add(rowsAsListOfValues[1]);
        if (kDebugMode) {
          print(rowsAsListOfValues[1]);
        }
        progress.value = false;
      }else{
        progress.value = false;
      }
    }
  }
}