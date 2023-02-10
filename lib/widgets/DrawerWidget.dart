import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: 200,
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              onTap: () {},
              leading: Image.asset('assets/img/company.png'),
              title: const Text("Home"),
            ),
            ListTile(
              onTap: () {},
              leading: Image.asset('assets/img/blogs_icon.png'),
              title: const Text("Blogs"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: const Text("Share with friends"),
            ),
            ListTile(
              onTap: () {},
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
}
