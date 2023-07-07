import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class EmojiPicker extends StatelessWidget {
  const EmojiPicker({
    super.key,
    required this.emojiList,
    required this.initialIdx,
    this.onEmojiChanged,
  });

  final List<String> emojiList;
  final int initialIdx;
  final void Function(String emoji, int index)? onEmojiChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorsUtils.foregroundBlack,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Center(
          child: Text(
            "Category_Emojis".tr,
            style: const TextStyle(color: ColorsUtils.neon),
          ),
        ),
        content: Container(
          height: 64,
          margin: const EdgeInsets.only(left: 15),
          child: CarouselSlider.builder(
            itemCount: emojiList.length,
            itemBuilder: (context, index, pageIdx) => Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: initialIdx == index
                        ? ColorsUtils.bacground
                        : ColorsUtils.bacground.withOpacity(0.3),
                    borderRadius:
                        BorderRadius.circular(initialIdx == index ? 64 : 20)),
                width: 64,
                child: Center(
                  child: Text(
                    emojiList[index],
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
                initialPage: initialIdx,
                onPageChanged: (index, reason) =>
                    onEmojiChanged?.call(emojiList[index], index),
                aspectRatio: 1,
                enlargeCenterPage: true,
                viewportFraction: 0.4,
                scrollDirection: Axis.horizontal),
          ),
        ));
  }
}
