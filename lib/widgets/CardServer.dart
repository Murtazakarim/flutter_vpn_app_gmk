import 'package:flutter/material.dart';
import 'package:vpn/appStyle/appColors.dart';

class CardServer extends StatelessWidget {
  String countryCode;
  String countryName;
  CardServer({Key? key, required this.countryCode, required this.countryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.colorBtn,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Image.asset(
            'icons/flags/png/${countryCode.toLowerCase()}.png',
            package: 'country_icons',
            height: 20,
            width: 25,
            fit: BoxFit.fill,
          ),
          const SizedBox(width: 16),
          Text(
            countryName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            'Select',
            style: TextStyle(fontSize: 16, color: AppColors.colorLightGreen),
          ),
        ],
      ),
    );
  }
}
