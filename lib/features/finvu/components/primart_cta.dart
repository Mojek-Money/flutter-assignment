// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:flutter/material.dart';

class PrimaryCTA extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonName;
  final String? loadingText;
  final bool enabled;
  final bool? isLoading;
  final Widget? leftIcon;
  final Icon? rightIcon;
  final double? fontSize;
  final String? fontFamily;
  final EdgeInsets? padding;

  const PrimaryCTA(
      {super.key,
      this.onPressed,
      required this.buttonName,
      required this.enabled,
      this.loadingText,
      this.isLoading,
      this.leftIcon,
      this.rightIcon,
      this.fontSize,
      this.fontFamily,
      this.padding});

  @override
  Widget build(BuildContext context) {
    bool _enabled = enabled;
    bool _isLoading = isLoading ?? false;
    Function()? _onPressed = onPressed ?? () {};
    String _loadingText = loadingText ?? "loading";

    return Container(
      height: 45,
      padding: padding,
      decoration: BoxDecoration(
        color: (_enabled && !_isLoading)
            ? ConstantColor.primaryColor
            : ConstantColor.gray_200.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8), // Animate shape
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_isLoading ? 22.5 : 8),
        child: IgnorePointer(
          ignoring: !(_enabled && !_isLoading),
          child: TextButton(
            style: TextButton.styleFrom(
                elevation: 0,
                backgroundColor: (_enabled && !_isLoading)
                    ? ConstantColor.primaryColor
                    : ConstantColor.gray_200.withOpacity(0.6),
                foregroundColor: ConstantColor.backgroundWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: const EdgeInsets.only(bottom: 1.5)),
            onPressed: () async {
              // Add your button click action here
              if (_enabled && !_isLoading) {
                _onPressed() ?? () {};
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                leftIcon ?? Container(),
                if (_isLoading)
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: ConstantColor.gray_300,
                      strokeWidth: 2,
                    ),
                  ),
                if (_isLoading) const SizedBox(width: 8),
                if (leftIcon != null) const SizedBox(width: 8),
                fontSize != null
                    ? Fonts.dynamicText(
                        _isLoading ? _loadingText : buttonName,
                        fontSize!,
                        500,
                        color: (_enabled && !_isLoading)
                            ? ConstantColor.backgroundWhite
                            : ConstantColor.gray_300,
                      )
                    : Fonts.dynamicText(
                        _isLoading ? _loadingText : buttonName,
                        16,
                        500,
                        color: (_enabled && !_isLoading)
                            ? ConstantColor.backgroundWhite
                            : ConstantColor.gray_300,
                      ),
                if (rightIcon != null) const SizedBox(width: 8),
                if (!_isLoading) rightIcon ?? Container(),
              ],
            ), // Set button text
          ),
        ),
      ),
    );
  }
}
