import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt_app/providers/controllers/home_provider.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_style.dart';

class CustomDatePicker extends StatelessWidget {
  final HomeProvider provider;
  CustomDatePicker({this.provider});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 10,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[300]),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, bottom: 10, top: 25, left: 20),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    provider.setDate = DateTime.now();
                    provider.setSaveSelection = false;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, top: 5, bottom: 5, left: 20),
                    child: Text(
                      "Reset",
                      style: AppStyle.greyMedium12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Select Date",
                    textAlign: TextAlign.center,
                    style:
                        AppStyle.blackMedium18.copyWith(color: AppColors.green),
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.setSaveSelection = true;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, top: 5, bottom: 5, left: 20),
                    child: Text(
                      "Done",
                      style: AppStyle.greyMedium12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: provider.selectedDate,
                onDateTimeChanged: (val) {
                  provider.setDate = val;
                }),
          ),
        ],
      ),
    );
  }
}
