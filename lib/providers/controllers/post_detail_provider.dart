import 'dart:async';
import 'package:product_hunt_app/models/post_model.dart';
import 'package:product_hunt_app/providers/base/provider_base.dart';
import 'package:product_hunt_app/providers/base/provider_helpers.dart';
import 'package:product_hunt_app/providers/base/provider_response.dart';
import 'package:product_hunt_app/services/api_service/api_services.dart';
import 'package:product_hunt_app/utils/app_enums.dart';
import 'package:product_hunt_app/utils/app_keys.dart';

class PostDetailProvider extends ProviderBase {
  PostDetailProvider(Post postModel) {
    _post = postModel;
    getLatestProducts(_post.id);
  }

  Post _post;
  Post get post => _post;

  final _apiServices = ApiServices();

  Post _collectionModel;
  Post get collectionModel => _collectionModel;

  Future<void> getLatestProducts(int postId) async {
    changeState(
      ProviderResponse(
        ProviderState.loading,
        ProviderEvent.fetchPostDetail,
      ),
    );

    final response = await _apiServices.apiRequest(
      ApiRequestType.apiGet,
      ProviderEvent.fetchPostDetail,
      '${ApiEndPoints.product}/$postId',
      authHeader: true,
    );

    if (response.state == ProviderState.success) {
      _collectionModel = Post.fromJson(response.data["post"]);
    }

    changeState(response);
  }
}
