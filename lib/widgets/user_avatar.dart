import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String avatarUrl;
  final double radius;

  const UserAvatar({super.key, required this.avatarUrl, this.radius = 24});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFF6C63FF),
      backgroundImage: NetworkImage(avatarUrl),
      onBackgroundImageError: (_, __) {},
      child: null,
    );
  }
}
