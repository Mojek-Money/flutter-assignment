import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/image_handler.dart';
import 'package:flutter/material.dart';

class DataIsSecureText extends StatelessWidget {
  const DataIsSecureText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageHandler(
            image: "assets/shield_tick.svg", asset: true, h: 16, w: 16),
        Fonts.text12_500("Your data is 100% secure")
      ],
    );
  }
}
