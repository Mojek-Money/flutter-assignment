import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/image_handler.dart';
import 'package:flutter/material.dart';

class AAPartnerRow extends StatelessWidget {
  const AAPartnerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Fonts.dynamicText(
          "AA Partner",
          12,
          500,
          color: ConstantColor.gray_400,
        ),
        ImageHandler(
          image: "assets/finvu.png",
          h: 60,
          w: 60,
          asset: true,
        )
      ],
    );
  }
}
