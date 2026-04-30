import 'package:flutter_test/flutter_test.dart';
import 'package:superstars_network/services/user_service.dart';
import 'package:superstars_network/models/user_profile.dart';

void main() {
  group('UserService', () {
    late UserService service;

    setUp(() {
      service = UserService();
    });

    test('loads mock users on init', () {
      expect(service.discoveredUsers, isNotEmpty);
    });

    test('searchUsers returns all users for empty query', () {
      final results = service.searchUsers('');
      expect(results.length, equals(service.discoveredUsers.length));
    });

    test('searchUsers filters by name', () {
      final results = service.searchUsers('Alex');
      expect(results.every((u) =>
        u.name.toLowerCase().contains('alex') ||
        u.title.toLowerCase().contains('alex') ||
        u.company.toLowerCase().contains('alex')), isTrue);
    });

    test('sendConnectionRequest updates status to pending', () async {
      final userId = service.discoveredUsers.first.id;
      await service.sendConnectionRequest(userId);
      final updated = service.discoveredUsers.firstWhere((u) => u.id == userId);
      expect(updated.connectionStatus, equals(ConnectionStatus.pending));
    });

    test('feed is populated on init', () {
      expect(service.feed, isNotEmpty);
    });
  });

  group('UserProfile', () {
    test('copyWith preserves unchanged fields', () {
      final original = UserProfile.mock;
      final updated = original.copyWith(name: 'New Name');
      expect(updated.name, equals('New Name'));
      expect(updated.title, equals(original.title));
      expect(updated.id, equals(original.id));
    });

    test('fromJson and toJson are symmetric', () {
      final original = UserProfile.mock;
      final json = original.toJson();
      final restored = UserProfile.fromJson(json);
      expect(restored.name, equals(original.name));
      expect(restored.title, equals(original.title));
      expect(restored.skills, equals(original.skills));
    });
  });
}
