class VideoPitch {
  final String id;
  final String userId;
  final String userName;
  final String userTitle;
  final String userAvatarUrl;
  final String videoUrl;
  final String thumbnailUrl;
  final String title;
  final Duration duration;
  final int viewsCount;
  final int likesCount;
  final DateTime createdAt;
  final List<String> tags;

  const VideoPitch({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userTitle,
    required this.userAvatarUrl,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
    required this.duration,
    required this.viewsCount,
    required this.likesCount,
    required this.createdAt,
    required this.tags,
  });

  factory VideoPitch.fromJson(Map<String, dynamic> json) {
    return VideoPitch(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      userTitle: json['user_title'] as String,
      userAvatarUrl: json['user_avatar_url'] as String,
      videoUrl: json['video_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      title: json['title'] as String,
      duration: Duration(seconds: json['duration_seconds'] as int),
      viewsCount: json['views_count'] as int,
      likesCount: json['likes_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      tags: List<String>.from(json['tags'] as List),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_title': userTitle,
        'user_avatar_url': userAvatarUrl,
        'video_url': videoUrl,
        'thumbnail_url': thumbnailUrl,
        'title': title,
        'duration_seconds': duration.inSeconds,
        'views_count': viewsCount,
        'likes_count': likesCount,
        'created_at': createdAt.toIso8601String(),
        'tags': tags,
      };

  String get formattedDuration {
    final mins = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }
}
