import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_images.dart';

class CustomImageWidget extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final double borderRadius;
  final double leftMargin;
  final double rightMargin;
  final String errorImage;
  final BoxFit boxFit;

  CustomImageWidget(
      {@required this.url,
      this.height,
      this.width,
      this.borderRadius,
      this.leftMargin,
      this.rightMargin,
      this.errorImage,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin ?? 0, right: rightMargin ?? 0),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? 10.0),
          topRight: Radius.circular(borderRadius ?? 10.0),
        ),
        child: CachedNetworkImage(
          fit: boxFit ?? BoxFit.cover,
          imageUrl: url ?? '',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const Center(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            AppImages.logoBlack,
            fit: BoxFit.cover,
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? 10.0),
          topRight: Radius.circular(borderRadius ?? 10.0),
        ),
      ),
    );
  }
}
