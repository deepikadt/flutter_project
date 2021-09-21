import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_style.dart';

class BorderedTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;
  final Function(String) validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) onFieldSubmitted;
  final int maxLength;
  final String hintText;
  final Widget prefix;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final VoidCallback onTap;
  final int maxlines;

  BorderedTextField({
    this.labelText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.maxlines,
    this.inputFormatters = const [],
    this.onFieldSubmitted,
    this.maxLength,
    this.hintText,
    this.prefix,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(
              0.1,
            ),
            offset: const Offset(
              0,
              0,
            ),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: _textfield(
        context,
      ),
    );
  }

  Widget _textfield(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      controller: controller,
      obscureText: obscureText,
      style: AppStyle.greyMedium14,
      cursorColor: AppColors.black,
      validator: validator,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      maxLines: maxlines ?? 1,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.greyMedium14,
        labelText: labelText,
        counterText: '',
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        suffix: suffixIcon,
        prefix: prefix,
        contentPadding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
      ),
    );
  }
}
