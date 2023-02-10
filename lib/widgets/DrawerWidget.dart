import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpn/routes/routesName.dart';
import 'package:vpn/screens/vpnHomePage.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFFCFCFC),
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.22,
              color: const Color(0xFFF1F1F1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/img/banner.png',
                      width: 200,
                      height: 95,
                    )),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              onTap: () {

                Get.back();
              },
              leading: Image.asset('assets/img/company.png'),
              title: const Text("Home"),
            ),
            ListTile(
              onTap: () {
                _launchUrl(Uri.parse('https://vpn.hmstudio92.site/blog/'));
              },
              leading: Image.asset('assets/img/blogs_icon.png'),
              title: const Text("Blogs"),
            ),
            ListTile(
              onTap: () {
                Share.share('Get online privacy and security with just a tap! Download Unlimited VPN, the best VPN app for mobile devices. Connect to the internet securely, access restricted content, and protect your personal information.  Download from https://vpn.hmstudio92.site');
              },
              leading: const Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: const Text("Share with friends"),
            ),
            ListTile(
              onTap: () {
                _launchUrl(Uri.parse('https://vpn.hmstudio92.site'));
              },
              leading: const Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
              title: const Text("Visit Website"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
