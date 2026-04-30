import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../widgets/video_pitch_card.dart';
import '../widgets/user_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final userService = context.watch<UserService>();
    final user = auth.currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good ${_greeting()},',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white54,
                            ),
                      ),
                      Text(
                        user?.name.split(' ').first ?? 'there',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  if (user != null)
                    UserAvatar(avatarUrl: user.avatarUrl, radius: 20),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _StatsRow(user: user),
                  const SizedBox(height: 24),
                  Text(
                    'Latest Pitches',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pitch = userService.feed[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: VideoPitchCard(pitch: pitch),
                  );
                },
                childCount: userService.feed.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }
}

class _StatsRow extends StatelessWidget {
  final dynamic user;
  const _StatsRow({this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          label: 'Connections',
          value: '${user?.connectionsCount ?? 0}',
          icon: Icons.people_rounded,
          color: const Color(0xFF6C63FF),
        ),
        const SizedBox(width: 12),
        _StatCard(
          label: 'Profile Views',
          value: '248',
          icon: Icons.visibility_rounded,
          color: const Color(0xFFFF6584),
        ),
        const SizedBox(width: 12),
        _StatCard(
          label: 'Pitch Views',
          value: '1.2k',
          icon: Icons.play_circle_rounded,
          color: const Color(0xFF43E97B),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white54,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
