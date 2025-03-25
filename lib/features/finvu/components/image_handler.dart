import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageHandler extends StatelessWidget {
  String image;
  double? h;
  double? w;
  double? paddingR;
  double? paddingL;
  Color? color;
  bool? asset;
  ImageHandler({
    super.key,
    required this.image,
    this.h,
    this.w,
    this.paddingL,
    this.paddingR,
    this.color,
    this.asset = false,
  });

  @override
  Widget build(BuildContext context) {
    if (image != null && asset == false) {
      return Container(
          child: image.contains(".svg")
              ? Padding(
                  padding: EdgeInsets.only(
                      right: paddingR ?? 0.0, left: paddingL ?? 0.0),
                  child: SvgPicture.network(
                    image,
                    height: h ?? 30,
                    width: w ?? 30,
                    color: color,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    placeholderBuilder: (context) {
                      return Container();
                    },
                  ),
                )
              : image.contains(".png")
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: paddingR ?? 0.0, left: paddingL ?? 0.0),
                      child: Image.network(
                        image,
                        height: h ?? 30,
                        width: w ?? 30,
                        color: color,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        },
                      ),
                    )
                  : Container());
    } else if (image != null && asset == true) {
      return Container(
          child: image.contains(".svg")
              ? Padding(
                  padding: EdgeInsets.only(
                      right: paddingR ?? 0.0, left: paddingL ?? 0.0),
                  child: SvgPicture.asset(
                    image,
                    height: h ?? 30,
                    width: w ?? 30,
                    color: color,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    placeholderBuilder: (context) {
                      return Container();
                    },
                  ),
                )
              : image.contains(".png")
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: paddingR ?? 0.0, left: paddingL ?? 0.0),
                      child: Image.asset(
                        image,
                        height: h ?? 30,
                        width: w ?? 30,
                        color: color,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        },
                      ),
                    )
                  : Container());
    }
    return Container();
  }
}
