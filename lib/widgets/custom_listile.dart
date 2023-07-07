import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/utils/utils.dart';

class CustomListile extends StatelessWidget {
  const CustomListile({super.key, required this.title, required this.icon, this.route});
  final Widget icon;
  final String title;
  final route;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to(route),
        child: Container(
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: ColorsUtils.bacground.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ], color: ColorsUtils.bacground, borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
            ),
            leading: icon,
          ),
        ));
  }
}
