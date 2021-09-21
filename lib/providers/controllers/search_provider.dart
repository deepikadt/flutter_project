import 'dart:async';
import 'package:product_hunt_app/models/post_model.dart';
import 'package:product_hunt_app/providers/base/provider_base.dart';
import 'package:product_hunt_app/providers/base/provider_helpers.dart';
import 'package:product_hunt_app/providers/base/provider_response.dart';
import 'package:product_hunt_app/services/db_service/database.dart';

class SearchProvider extends ProviderBase {
  final _appDatabaseBase = AppDatabase();

  List<Post> searchResult = [];

  Future<void> searchProducts(String searchText) async {
    changeState(
      ProviderResponse(
        ProviderState.loading,
        ProviderEvent.searchProducts,
      ),
    );
    searchResult.clear();

    PostModel response = await _appDatabaseBase.fetchProductData();

    response.posts.forEach((element) {
      if (element.name.contains(searchText) ||
          element.tagline.contains(searchText)) searchResult.add(element);
    });

    changeState(
      ProviderResponse(
        ProviderState.success,
        ProviderEvent.searchProducts,
      ),
    );
  }
}
