import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isAnimated;
  final Widget icon;
  final Color buttonColor;
  final bool enabled;
  final bool showBorder;

  CustomButton({
    @required this.onPressed,
    @required this.label,
    this.isAnimated = false,
    this.icon,
    this.buttonColor,
    this.enabled = true,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      constraints: const BoxConstraints(maxWidth: 300.0),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: showBorder && enabled
            ? Border.all(
                color: enabled
                    ? AppColors.blue.withOpacity(0.2)
                    : AppColors.greyMedium.withOpacity(0.2),
                width: 2.0,
              )
            : Border.all(color: AppColors.transparent),
        boxShadow: [
          if (enabled)
            BoxShadow(
              color: AppColors.blue.withOpacity(0.3),
              offset: const Offset(1, 1),
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
        ],
      ),
      child: TextButton(
        onPressed: isAnimated
            ? () {}
            : enabled
                ? onPressed
                : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isAnimated
              ? [
                  const CircularProgressIndicator(
                      strokeWidth: 4.0, backgroundColor: AppColors.white)
                ]
              : [
                  icon ?? const SizedBox.shrink(),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(label, style: AppStyle.whiteBold16),
                  )
                ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(
            enabled
                ? buttonColor ?? AppColors.blue
                : buttonColor == null
                    ? AppColors.blue.withOpacity(0.5)
                    : buttonColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
