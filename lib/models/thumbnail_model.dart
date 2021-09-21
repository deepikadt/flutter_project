import 'package:product_hunt_app/utils/app_enums.dart';

class Thumbnail {
  Thumbnail({
    this.id,
    this.mediaType,
    this.imageUrl,
  });

  String id;
  MediaType mediaType;
  String imageUrl;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        id: json["id"],
        mediaType: mediaTypeValues.map[json["media_type"]],
        imageUrl: json["image_url"],
      );
}
