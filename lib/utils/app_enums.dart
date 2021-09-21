import 'package:product_hunt_app/generated/l10n.dart';

enum MediaType {
  video,
  image,
}

final mediaTypeValues = EnumValues(
  {
    S.current.video: MediaType.video,
    S.current.image: MediaType.image,
  },
);

enum ApiRequestType {
  apiGet,
  apiPost,
  apiPut,
  apiPatch,
  apiDelete,
}

enum BuildType {
  dev,
  prod,
  uat,
}

enum ApiContentType {
  json,
  formData,
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    _reverseMap = _reverseMap ??
        map.map(
          (k, v) => MapEntry(v, k),
        );

    return _reverseMap;
  }
}
