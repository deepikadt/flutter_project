class Comment {
  Comment({
    this.id,
    this.body,
    this.createdAt,
    this.parentCommentId,
    this.userId,
    this.subjectId,
    this.childCommentsCount,
    this.url,
    this.postId,
    this.sticky,
    this.votes,
    this.childComments,
    this.maker,
    this.hunter,
    this.liveGuest,
  });

  int id;
  String body;
  DateTime createdAt;
  int parentCommentId;
  int userId;
  int subjectId;
  int childCommentsCount;
  String url;
  int postId;
  bool sticky;
  int votes;
  List<Comment> childComments;
  bool maker;
  bool hunter;
  bool liveGuest;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        createdAt: DateTime.tryParse(json["created_at"]),
        parentCommentId: json["parent_comment_id"],
        userId: json["user_id"],
        subjectId: json["subject_id"],
        childCommentsCount: json["child_comments_count"],
        url: json["url"],
        postId: json["post_id"],
        sticky: json["sticky"],
        votes: json["votes"],
        childComments: List<Comment>.from(
            json["child_comments"].map((x) => Comment.fromJson(x))),
        maker: json["maker"],
        hunter: json["hunter"],
        liveGuest: json["live_guest"],
      );
}
