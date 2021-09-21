import 'package:product_hunt_app/providers/base/provider_helpers.dart';

class ProviderResponse<T> {
  final ProviderState state;
  final ProviderEvent event;
  final T data;
  final String message;
  final int statusCode;
  final Type exceptionType;

  ProviderResponse(
    this.state,
    this.event, {
    this.data,
    this.message,
    this.statusCode,
    this.exceptionType,
  });
}
