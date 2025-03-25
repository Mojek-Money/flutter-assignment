import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/primart_cta.dart';
import 'package:flutter/material.dart';

class CloseBankConnection extends StatelessWidget {
  final VoidCallback onPressed;
  const CloseBankConnection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColor.transparentColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          closeIcon(context),
          Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                  color: ConstantColor.backgroundWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Fonts.dynamicText("Stop connecting\nbank accounts", 28, 600,
                      align: TextAlign.center),
                  const SizedBox(height: 16),
                  Fonts.dynamicText(
                      "If you exit now, you’ll need to restart\nthe process.",
                      14,
                      500,
                      align: TextAlign.center),
                  const SizedBox(height: 32),
                  PrimaryCTA(
                    buttonName: "Abort connecting",
                    enabled: true,
                    onPressed: onPressed,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Fonts.dynamicText("Discard", 14, 500,
                          color: ConstantColor.gray_600))
                ],
              ))
        ],
      ),
    );
  }

  Widget closeIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: ConstantColor.backgroundWhite,
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(
            Icons.close,
            color: ConstantColor.gray_800,
            size: 24,
          )),
    );
  }
}
