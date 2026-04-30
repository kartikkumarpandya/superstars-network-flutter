import 'package:flutter/material.dart';
import '../models/video_pitch.dart';
import 'user_avatar.dart';

class VideoPitchCard extends StatelessWidget {
  final VideoPitch pitch;
  const VideoPitchCard({super.key, required this.pitch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  pitch.thumbnailUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: const Color(0xFF6C63FF).withOpacity(0.2),
                    child: const Icon(Icons.play_circle_rounded,
                        color: Color(0xFF6C63FF), size: 48),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    pitch.formattedDuration,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 32),
                  ),
                ),
              ),
            ],
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pitch.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    UserAvatar(avatarUrl: pitch.userAvatarUrl, radius: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pitch.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          Text(pitch.userTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ),
                    _PitchStat(icon: Icons.visibility_outlined, value: '${pitch.viewsCount}'),
                    const SizedBox(width: 12),
                    _PitchStat(icon: Icons.favorite_outline, value: '${pitch.likesCount}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PitchStat extends StatelessWidget {
  final IconData icon;
  final String value;
  const _PitchStat({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white38),
        const SizedBox(width: 3),
        Text(value,
            style: const TextStyle(color: Colors.white38, fontSize: 12)),
      ],
    );
  }
}
