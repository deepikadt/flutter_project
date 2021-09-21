import 'package:flutter/material.dart';
import 'package:product_hunt_app/models/post_model.dart';
import 'package:product_hunt_app/ui/custom_widgets/custom_image_widget.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_routes.dart';
import 'package:product_hunt_app/utils/app_style.dart';

class ProductItem extends StatelessWidget {
  final Post model;
  ProductItem({@required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.postDetail, arguments: model);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        child: Column(
          children: [
            CustomImageWidget(
                borderRadius: 15.0,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                url: model.thumbnail?.imageUrl ?? model.imgUrl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                model.name,
                style: AppStyle.greyBold10
                    .copyWith(fontSize: 20.0, color: AppColors.green),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                model.tagline,
                style: AppStyle.greyBold10.copyWith(fontSize: 12.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
