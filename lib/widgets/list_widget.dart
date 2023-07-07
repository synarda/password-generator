import 'package:flutter/material.dart' hide DrawerController;
import 'package:get/get.dart';
import 'package:password_generator/controllers/drawer_controller.dart';
import 'package:password_generator/models/password.dart';
import 'package:password_generator/screens/delete_alert.dart';

import '../utils/utils.dart';

class ListWidget extends GetView<DrawerControllers> {
  const ListWidget({super.key, required this.emoji, required this.password});

  final String emoji;
  final PasswordModel password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: ColorsUtils.bacground.withOpacity(0.8),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
      child: ListTile(
          title: Text(
            password.name.toString(),
            style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          minLeadingWidth: 0,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorsUtils.foregroundBlack,
            ),
            child: Text(
              emoji,
              style: const TextStyle(color: ColorsUtils.textColor, fontSize: 20),
            ),
          ),
          subtitle: Obx(
            () => Padding(
                padding: const EdgeInsets.only(top: 15),
                child: controller.seePassword.value
                    ? Text(
                        password.password,
                        style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
                      )
                    : Text(
                        controller.locedPassword(
                          password.password,
                        ),
                        style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
                      )),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    controller.share(password.password);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: ColorsUtils.neon,
                    size: 25,
                  )),
              IconButton(
                padding: const EdgeInsets.all(5),
                constraints: const BoxConstraints(),
                onPressed: () async {
                  Get.dialog(DeleteAlert(
                    passId: password.uid,
                  ));
                },
                icon: const Icon(
                  Icons.delete,
                  color: ColorsUtils.neon,
                  size: 25,
                ),
              )
            ],
          )),
    );
  }
}
