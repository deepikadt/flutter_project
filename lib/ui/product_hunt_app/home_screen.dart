import 'package:flutter/material.dart';
import 'package:product_hunt_app/providers/base/provider_consumer.dart';
import 'package:product_hunt_app/providers/controllers/home_provider.dart';
import 'package:product_hunt_app/ui/product_hunt_app/custom_widgets/error_views/no_data_found.dart';
import 'package:product_hunt_app/utils/app_routes.dart';
import 'package:product_hunt_app/utils/global.dart';

import 'custom_widgets/custom_textfields/bordered_textfield.dart';
import 'custom_widgets/error_views/loading_view.dart';
import 'custom_widgets/filter_widget.dart';
import 'custom_widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: const Text('Products'),
          centerTitle: true,
        ),
        body: ProviderConsumer<HomeProvider>(
          defaultView: (context, provider, _) => _body(provider),
          loadingView: (context, provider, _) => _loadingView(provider),
        ));
  }

  Widget _loadingView(HomeProvider homeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_utilityWidget(homeProvider), LoadingView()],
    );
  }

  Widget _body(HomeProvider homeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _utilityWidget(homeProvider),
        !isNullOrEmpty(homeProvider.collectionModel) &&
                homeProvider.collectionModel.posts.isNotEmpty
            ? Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: _collectionView(homeProvider),
                ),
              )
            : NoDataFound(),
      ],
    );
  }

  Widget _collectionView(HomeProvider homeProvider) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      addAutomaticKeepAlives: true,
      itemCount: homeProvider.collectionModel.posts.length,
      itemBuilder: (context, index) {
        return ProductItem(
          model: homeProvider.collectionModel.posts[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 30,
        );
      },
    );
  }

  Widget _utilityWidget(HomeProvider homeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BorderedTextField(
          readOnly: true,
          hintText: 'Search Products by name or tagname..',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.searchProducts);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        FilterWidget(provider: homeProvider),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
