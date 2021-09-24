import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_images.dart';
import 'package:product_hunt_app/utils/app_routes.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _callAppConfigApi();
  }

  void _callAppConfigApi() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Navigator.pushNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.green,
        alignment: Alignment.center,
        child: Image.asset(
          AppImages.logoTransparent,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
