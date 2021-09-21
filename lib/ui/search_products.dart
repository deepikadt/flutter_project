import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt_app/providers/base/provider_consumer.dart';
import 'package:product_hunt_app/providers/base/provider_helpers.dart';
import 'package:product_hunt_app/providers/controllers/home_provider.dart';
import 'package:product_hunt_app/providers/controllers/search_provider.dart';
import 'package:product_hunt_app/ui/custom_widgets/custom_textfields/bordered_textfield.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_routes.dart';
import 'package:product_hunt_app/utils/app_style.dart';

class SearchProducts extends StatefulWidget {
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ProviderConsumer<SearchProvider>(
          defaultView: (context, provider, _) => _body(provider),
        ));
  }

  Widget _body(SearchProvider provider) {
    return Column(
      children: [
        BorderedTextField(
          readOnly: false,
          hintText: 'Search Products by name or tagname..',
          controller: _searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (_searchController.text.trim().isEmpty) {
              provider.searchResult.clear();
              setState(() {});
            }
            if (value.trim().length > 1) provider.searchProducts(value);
          },
        ),
        provider.state == ProviderState.loading
            ? const Center(child: CircularProgressIndicator())
            : provider.searchResult == null ||
                    _searchController.text.trim().isEmpty
                ? const SizedBox()
                : Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 30.0),
                      itemCount: provider.searchResult.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.postDetail,
                                  arguments: provider.searchResult[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(provider.searchResult[index].name,
                                    style: AppStyle.green600Bold15
                                        .copyWith(fontSize: 15.0)),
                                const SizedBox(height: 10),
                                Text(provider.searchResult[index].tagline,
                                    style: AppStyle.blackMedium14),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: AppColors.black,
                        );
                      },
                    ),
                  )
      ],
    );
  }
}
