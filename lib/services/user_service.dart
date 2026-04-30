import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/video_pitch.dart';

class UserService extends ChangeNotifier {
  final List<UserProfile> _discoveredUsers = [];
  final List<UserProfile> _connections = [];
  final List<VideoPitch> _feed = [];
  bool _isLoading = false;

  List<UserProfile> get discoveredUsers => List.unmodifiable(_discoveredUsers);
  List<UserProfile> get connections => List.unmodifiable(_connections);
  List<VideoPitch> get feed => List.unmodifiable(_feed);
  bool get isLoading => _isLoading;

  UserService() {
    _loadMockData();
  }

  void _loadMockData() {
    _discoveredUsers.addAll(_generateMockUsers());
    _connections.addAll(_generateMockConnections());
    _feed.addAll(_generateMockFeed());
    notifyListeners();
  }

  Future<void> sendConnectionRequest(String userId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    final index = _discoveredUsers.indexWhere((u) => u.id == userId);
    if (index != -1) {
      _discoveredUsers[index] = _discoveredUsers[index].copyWith(
        connectionStatus: ConnectionStatus.pending,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> acceptConnection(String userId) async {
    final index = _discoveredUsers.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = _discoveredUsers[index].copyWith(
        connectionStatus: ConnectionStatus.connected,
      );
      _discoveredUsers[index] = user;
      _connections.add(user);
      notifyListeners();
    }
  }

  Future<void> refreshFeed() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }

  List<UserProfile> searchUsers(String query) {
    if (query.isEmpty) return _discoveredUsers;
    final q = query.toLowerCase();
    return _discoveredUsers.where((u) {
      return u.name.toLowerCase().contains(q) ||
          u.title.toLowerCase().contains(q) ||
          u.company.toLowerCase().contains(q) ||
          u.skills.any((s) => s.toLowerCase().contains(q));
    }).toList();
  }

  List<UserProfile> _generateMockUsers() {
    final names = ['Alex Rivera', 'Priya Sharma', 'Jordan Lee', 'Sofia Chen', 'Marcus Williams'];
    final titles = ['Product Manager', 'UX Designer', 'Software Engineer', 'Data Scientist', 'CEO'];
    final companies = ['Google', 'Airbnb', 'Stripe', 'OpenAI', 'Meta'];

    return List.generate(names.length, (i) => UserProfile(
      id: 'user_$i',
      name: names[i],
      title: titles[i],
      company: companies[i],
      bio: 'Passionate professional building the future of ${companies[i]}.',
      avatarUrl: 'https://i.pravatar.cc/300?u=${names[i].replaceAll(' ', '')}',
      skills: ['Leadership', 'Strategy', 'Innovation'],
      industries: ['Technology', 'SaaS'],
      connectionsCount: 100 + i * 47,
      joinedAt: DateTime(2024, i + 1, 1),
    ));
  }

  List<UserProfile> _generateMockConnections() {
    return [
      UserProfile(
        id: 'conn_1',
        name: 'Jamie Park',
        title: 'Venture Capitalist',
        company: 'Sequoia Capital',
        bio: 'Investing in the next generation of startups.',
        avatarUrl: 'https://i.pravatar.cc/300?u=jamie',
        skills: ['Investing', 'Due Diligence', 'Portfolio Management'],
        industries: ['Finance', 'Technology'],
        connectionStatus: ConnectionStatus.connected,
        connectionsCount: 892,
        joinedAt: DateTime(2023, 6, 10),
      ),
    ];
  }

  List<VideoPitch> _generateMockFeed() {
    return [
      VideoPitch(
        id: 'pitch_1',
        userId: 'user_0',
        userName: 'Alex Rivera',
        userTitle: 'Product Manager at Google',
        userAvatarUrl: 'https://i.pravatar.cc/300?u=AlexRivera',
        videoUrl: 'https://www.example.com/video1.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/pitch1/400/300',
        title: 'How I scaled our user base from 0 to 1M',
        duration: const Duration(minutes: 2, seconds: 34),
        viewsCount: 1420,
        likesCount: 87,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        tags: ['product', 'growth', 'startup'],
      ),
      VideoPitch(
        id: 'pitch_2',
        userId: 'user_1',
        userName: 'Priya Sharma',
        userTitle: 'UX Designer at Airbnb',
        userAvatarUrl: 'https://i.pravatar.cc/300?u=PriyaSharma',
        videoUrl: 'https://www.example.com/video2.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/pitch2/400/300',
        title: 'Design systems that teams actually use',
        duration: const Duration(minutes: 1, seconds: 58),
        viewsCount: 894,
        likesCount: 63,
        createdAt: DateTime.now().subtract(const Duration(hours: 7)),
        tags: ['design', 'ux', 'systems'],
      ),
    ];
  }
}
