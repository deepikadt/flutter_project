import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_hunt_app/providers/controllers/home_provider.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_style.dart';

import 'bottom_sheets/date_picker_dialog.dart';

class FilterWidget extends StatelessWidget {
  final HomeProvider provider;
  FilterWidget({@required this.provider});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: () {
          _pickDate(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 6.0),
                child: Icon(Icons.calendar_today_rounded, size: 20)),
            Text(DateFormat('yMMMMd').format(provider.currentDate),
                style: AppStyle.blackBold12),
            const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 10),
                child: Icon(Icons.arrow_drop_down, size: 25.0)),
          ],
        ),
      ),
    );
  }

  void _pickDate(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) => CustomDatePicker(
              provider: provider,
            ));
  }
}
