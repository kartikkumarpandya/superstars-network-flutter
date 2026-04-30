import 'package:uuid/uuid.dart';

class UserProfile {
  final String id;
  final String name;
  final String title;
  final String company;
  final String bio;
  final String avatarUrl;
  final String? videoPitchUrl;
  final List<String> skills;
  final List<String> industries;
  final ConnectionStatus connectionStatus;
  final int connectionsCount;
  final DateTime joinedAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.title,
    required this.company,
    required this.bio,
    required this.avatarUrl,
    this.videoPitchUrl,
    required this.skills,
    required this.industries,
    this.connectionStatus = ConnectionStatus.none,
    this.connectionsCount = 0,
    required this.joinedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      bio: json['bio'] as String,
      avatarUrl: json['avatar_url'] as String,
      videoPitchUrl: json['video_pitch_url'] as String?,
      skills: List<String>.from(json['skills'] as List),
      industries: List<String>.from(json['industries'] as List),
      connectionStatus: ConnectionStatus.values.firstWhere(
        (e) => e.name == json['connection_status'],
        orElse: () => ConnectionStatus.none,
      ),
      connectionsCount: json['connections_count'] as int? ?? 0,
      joinedAt: DateTime.parse(json['joined_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'company': company,
        'bio': bio,
        'avatar_url': avatarUrl,
        'video_pitch_url': videoPitchUrl,
        'skills': skills,
        'industries': industries,
        'connection_status': connectionStatus.name,
        'connections_count': connectionsCount,
        'joined_at': joinedAt.toIso8601String(),
      };

  UserProfile copyWith({
    String? name,
    String? title,
    String? company,
    String? bio,
    String? avatarUrl,
    String? videoPitchUrl,
    List<String>? skills,
    List<String>? industries,
    ConnectionStatus? connectionStatus,
    int? connectionsCount,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      title: title ?? this.title,
      company: company ?? this.company,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      videoPitchUrl: videoPitchUrl ?? this.videoPitchUrl,
      skills: skills ?? this.skills,
      industries: industries ?? this.industries,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      connectionsCount: connectionsCount ?? this.connectionsCount,
      joinedAt: joinedAt,
    );
  }

  static UserProfile get mock => UserProfile(
        id: const Uuid().v4(),
        name: 'Kartikkumar Pandya',
        title: 'Software Engineer',
        company: 'Superstars Network',
        bio: 'Building the future of professional video networking.',
        avatarUrl: 'https://i.pravatar.cc/300?u=kartik',
        skills: ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
        industries: ['Technology', 'Networking', 'SaaS'],
        connectionsCount: 142,
        joinedAt: DateTime(2025, 1, 15),
      );
}

enum ConnectionStatus { none, pending, connected, declined }
