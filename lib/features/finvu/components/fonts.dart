import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:flutter/material.dart';

class Fonts {
  static Text text6_600(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 6,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text10_500(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text12_500(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text12_500_italic(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      TextDecoration? decoration}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        decoration: decoration,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text12_500_underline(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        decoration: TextDecoration.underline,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text12_600(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text13_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_400(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 400)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_500(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_500_multiline(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      FontStyle? fontStyle}) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontStyle: fontStyle,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_500_italic(String text,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      TextDecoration? decoration}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        decoration: decoration,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_500_underline(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        decoration: TextDecoration.underline,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text14_700(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 700)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text15_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text15_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text16_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text16_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_800,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text16_800(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: color ?? ConstantColor.gray_800,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 800)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text17_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text17_700(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 700)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text18_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text18_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: color ?? ConstantColor.gray_700,
          height: lineHeight),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text20_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text20_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text20_700(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 700)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text24_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text24_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text24_700(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 700)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text25_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text32_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text36_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text36_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text36_700(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 700)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text40_500(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 500)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text40_700(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 700)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text text45_600(String text,
      {Color? color, TextAlign? align, double? lineHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: color ?? ConstantColor.gray_700,
        height: lineHeight,
        fontVariations: const [FontVariation('wght', 600)],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }

  static Text dynamicText(String? text, double fontSize, double fontWeight,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      TextDecoration? decoration,
      int? maxLines}) {
    return Text(
      text ?? "",
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? ConstantColor.gray_800,
        height: lineHeight,
        fontFamily: "NotoSans",
        decoration: decoration,
        decorationColor: color,
        fontVariations: [FontVariation('wght', fontWeight ?? 500)],
      ),
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle dynamicStyle(double fontSize, double fontWeight,
      {Color? color,
      TextAlign? align,
      double? lineHeight,
      TextDecoration? decoration}) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? ConstantColor.gray_700,
      height: lineHeight,
      fontFamily: "NotoSans",
      decoration: decoration,
      fontVariations: [FontVariation('wght', fontWeight ?? 500)],
    );
  }
}
