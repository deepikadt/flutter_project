import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_images.dart';
import 'package:product_hunt_app/utils/app_style.dart';

class ContentUnavailable extends StatelessWidget {
  final String description;

  ContentUnavailable({
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20.0,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logo,
            height: 100.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'Content Not Available',
            style: AppStyle.blackMedium16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
