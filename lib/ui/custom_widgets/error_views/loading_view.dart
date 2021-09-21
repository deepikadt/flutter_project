import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_colors.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(
          20.0,
        ),
        width: double.infinity,
        child: const Center(
            child: CircularProgressIndicator(
          color: AppColors.green,
        )));
  }
}
