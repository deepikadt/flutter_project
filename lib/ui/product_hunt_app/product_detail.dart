import 'package:flutter/material.dart';
import 'package:product_hunt_app/models/post_model.dart';
import 'package:product_hunt_app/providers/base/provider_consumer.dart';
import 'package:product_hunt_app/providers/controllers/post_detail_provider.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_style.dart';

import 'custom_widgets/custom_image_widget.dart';
import 'custom_widgets/error_views/loading_view.dart';
import 'custom_widgets/error_views/no_internet_view.dart';
import 'custom_widgets/error_views/something_went_wrong.dart';

class PostDetail extends StatelessWidget {
  final Post postModel;
  PostDetail({@required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          postModel.name,
          style: AppStyle.blackBold20.copyWith(color: AppColors.green),
          maxLines: 2,
          overflow: TextOverflow.clip,
        ),
      ),
      body: ProviderConsumer<PostDetailProvider>(
        defaultView: (context, provider, _) => _body(provider, context),
        loadingView: (context, provider, _) => LoadingView(),
        failedView: (context, provider, _) => SomethingWentWrong(
          onPressed: () {
            provider.getLatestProducts(provider.post.id);
          },
        ),
        noInternetView: (context, provider, _) => NoInternet(onPressed: () {
          provider.getLatestProducts(provider.post.id);
        }),
      ),
    );
  }

  Widget _body(PostDetailProvider provider, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomImageWidget(
                borderRadius: 15.0,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                url: provider.collectionModel.thumbnail?.imageUrl ??
                    provider.collectionModel.imgUrl),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                provider.collectionModel.tagline,
                style: AppStyle.greyBold10.copyWith(fontSize: 12.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Text(
              "Comments",
              style: AppStyle.blackBold16,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: provider.collectionModel?.comments?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(provider.collectionModel.comments[index].body,
                          style: AppStyle.blackMedium16),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
