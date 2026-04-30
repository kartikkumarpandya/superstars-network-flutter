import 'package:flutter/material.dart';

class VideoPitchScreen extends StatelessWidget {
  const VideoPitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Pitch',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Record a 60-second video to introduce yourself',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white54,
                    ),
              ),
              const SizedBox(height: 32),
              Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withOpacity(0.4),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.videocam_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Tap to record your pitch',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Max 60 seconds · Shows on your profile',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white38,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _TipCard(
                icon: Icons.lightbulb_rounded,
                color: const Color(0xFFFFD166),
                title: 'Pro Tip',
                body: 'State your name, current role, and one thing you\'re building or learning.',
              ),
              const SizedBox(height: 12),
              _TipCard(
                icon: Icons.timer_rounded,
                color: const Color(0xFF43E97B),
                title: 'Keep it concise',
                body: 'Pitches under 45 seconds get 3x more connection requests.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  const _TipCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(body,
                    style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
