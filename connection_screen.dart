import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';
import '../widgets/user_avatar.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = context.watch<UserService>();
    final connections = userService.connections;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'My Network',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${connections.length} connections',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white54,
                    ),
              ),
              const SizedBox(height: 24),
              if (connections.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.people_outline_rounded,
                            size: 64, color: Colors.white24),
                        const SizedBox(height: 16),
                        Text(
                          'No connections yet',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white38,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Discover professionals and start connecting',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white24,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: connections.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final user = connections[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A2E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            UserAvatar(avatarUrl: user.avatarUrl, radius: 28),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(fontWeight: FontWeight.bold)),
                                  Text('${user.title} · ${user.company}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.white54)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline_rounded,
                                  color: Color(0xFF6C63FF), size: 20),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
