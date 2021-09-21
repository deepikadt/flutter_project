import 'dart:convert';
import 'package:product_hunt_app/models/comment_model.dart';
import 'package:product_hunt_app/models/thumbnail_model.dart';
import 'package:product_hunt_app/services/db_service/db_constants.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

class PostModel {
  PostModel({
    this.posts,
  });

  List<Post> posts;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );
}

class Post {
  Post(
      {this.commentsCount,
      this.id,
      this.name,
      this.tagline,
      this.slug,
      this.votesCount,
      this.day,
      this.categoryId,
      this.createdAt,
      this.discussionUrl,
      this.exclusive,
      this.featured,
      this.iosFeaturedAt,
      this.makerInside,
      this.redirectUrl,
      this.thumbnail,
      this.comments,
      this.imgUrl});

  int commentsCount;
  int id;
  String name;
  String tagline;
  String slug;
  int votesCount;
  DateTime day;
  dynamic categoryId;
  DateTime createdAt;
  String discussionUrl;
  dynamic exclusive;
  bool featured;
  bool iosFeaturedAt;
  bool makerInside;
  String redirectUrl;
  Thumbnail thumbnail;
  List<Comment> comments;
  String imgUrl;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        commentsCount: json["comments_count"],
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        slug: json["slug"],
        votesCount: json["votes_count"],
        day: DateTime.tryParse(json["day"]),
        categoryId: json["category_id"],
        createdAt: DateTime.tryParse(json["created_at"]),
        discussionUrl: json["discussion_url"],
        exclusive: json["exclusive"],
        featured: json["featured"],
        iosFeaturedAt: json["ios_featured_at"],
        makerInside: json["maker_inside"],
        redirectUrl: json["redirect_url"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        comments: json["comments"] != null
            ? List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x)))
            : null,
      );

  factory Post.fromJsonForDb(Map<String, dynamic> json) => Post(
        id: json[DbConstants.colId],
        name: json[DbConstants.colName],
        tagline: json[DbConstants.colTagline],
        imgUrl: json[DbConstants.colImageUrl],
      );
}
