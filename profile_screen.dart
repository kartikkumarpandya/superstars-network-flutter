import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/user_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthService>().currentUser;
    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF0F0F1A),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserAvatar(avatarUrl: user.avatarUrl, radius: 48),
                      const SizedBox(height: 12),
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${user.title} at ${user.company}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Section(
                  title: 'About',
                  child: Text(
                    user.bio,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          height: 1.6,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                _Section(
                  title: 'Skills',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: user.skills
                        .map((s) => _Chip(label: s))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                _Section(
                  title: 'Industries',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: user.industries
                        .map((i) => _Chip(label: i, color: const Color(0xFFFF6584)))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                _Section(
                  title: 'Stats',
                  child: Row(
                    children: [
                      _StatItem(label: 'Connections', value: '${user.connectionsCount}'),
                      const SizedBox(width: 24),
                      _StatItem(label: 'Pitch Views', value: '1.2k'),
                      const SizedBox(width: 24),
                      _StatItem(label: 'Profile Views', value: '248'),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, this.color = const Color(0xFF6C63FF)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 13)),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6C63FF),
                )),
        Text(label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white38,
                )),
      ],
    );
  }
}
