import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_images.dart';
import 'package:product_hunt_app/utils/app_style.dart';
import 'package:product_hunt_app/utils/global.dart';

class SomethingWentWrong extends StatelessWidget {
  final VoidCallback onPressed;
  final String description;

  SomethingWentWrong({
    @required this.onPressed,
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
          //error image
          Image.asset(
            AppImages.logo,
            height: 100.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          //Something went wrong
          Text(
            "Something went wrong",
            style: AppStyle.blackMedium16,
            textAlign: TextAlign.center,
          ),
          //
          Text(
            isNullOrEmpty(description) ? "No Internet Connection" : description,
            style: AppStyle.blackMedium16,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30.0,
          ),
          //retry button
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              "Retry",
              style: AppStyle.whiteBold16,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
