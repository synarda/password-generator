import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_generator/utils/utils.dart';

class LockPage extends HookWidget {
  const LockPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useState(false);
    useEffect(() {
      Timer? timer;
      timer = Timer.periodic(const Duration(milliseconds: 550), (timer) {
        if (timer.tick == 2) {
          state.value = true;
        } else if (timer.tick == 3) {
          FocusScope.of(context).unfocus();
          Get.back();
        }
      });
      return () {
        timer?.cancel();
        timer = null;
      };
    }, const []);

    return Scaffold(
      backgroundColor: ColorsUtils.foregroundBlack.withOpacity(0.1),
      body: Stack(
        children: <Widget>[
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsUtils.bacground.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsUtils.bacground.withOpacity(0.8),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("lib/assets/lock.json", repeat: false),
                          AnimatedOpacity(
                            opacity: state.value ? 1 : 0,
                            duration: const Duration(milliseconds: 150),
                            child: Text(
                              "password_saved".tr,
                              style: const TextStyle(color: ColorsUtils.textColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*SizedBox(
          height: 500,
          child: Lottie.asset("lib/assets/lock.json"),
        ), */