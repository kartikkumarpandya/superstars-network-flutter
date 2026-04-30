import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/discover_screen.dart';
import 'screens/video_pitch_screen.dart';
import 'screens/connection_screen.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SuperstarsApp());
}

class SuperstarsApp extends StatelessWidget {
  const SuperstarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserService()),
      ],
      child: MaterialApp.router(
        title: 'Superstars Network',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(path: '/', builder: (c, s) => const HomeScreen()),
        GoRoute(path: '/discover', builder: (c, s) => const DiscoverScreen()),
        GoRoute(path: '/pitch', builder: (c, s) => const VideoPitchScreen()),
        GoRoute(path: '/connections', builder: (c, s) => const ConnectionScreen()),
        GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
      ],
    ),
  ],
);

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<({String path, IconData icon, String label})> _tabs = [
    (path: '/', icon: Icons.home_rounded, label: 'Home'),
    (path: '/discover', icon: Icons.explore_rounded, label: 'Discover'),
    (path: '/pitch', icon: Icons.videocam_rounded, label: 'Pitch'),
    (path: '/connections', icon: Icons.people_rounded, label: 'Connect'),
    (path: '/profile', icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          context.go(_tabs[index].path);
        },
        destinations: _tabs
            .map((tab) => NavigationDestination(
                  icon: Icon(tab.icon),
                  label: tab.label,
                ))
            .toList(),
      ),
    );
  }
}

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFFFF6584),
          surface: const Color(0xFF1A1A2E),
          background: const Color(0xFF0F0F1A),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
        cardTheme: CardTheme(
          color: const Color(0xFF1A1A2E),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        fontFamily: 'SF Pro Display',
      );
}
