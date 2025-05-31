import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:solutech_technical_assessment_app/activities/activities.dart';

import 'mock_activity_repository.mocks.dart';

void main() {
  late MockActivityRepository mockRepository;
  late ActivityNotifier notifier;

  setUp(() {
    mockRepository = MockActivityRepository();
    notifier = ActivityNotifier(mockRepository);
  });

  test('emits data state when fetchActivities succeeds', () async {
    // Arrange
    final fakeActivities = [
      Activity(id: 1, description: 'Marketing', createdAt: DateTime.now()),
      Activity(id: 2, description: 'Training', createdAt: DateTime.now()),
    ];

    when(
      mockRepository.getActivities(),
    ).thenAnswer((_) async => Right(fakeActivities));

    // Act
    await notifier.fetchActivities();

    // Assert
    expect(notifier.state, isA<AsyncData<List<Activity>>>());
    expect(notifier.state.asData!.value, fakeActivities);
  });

  test('emits error state when fetchActivities fails', () async {
    // Arrange
    when(
      mockRepository.getActivities(),
    ).thenAnswer((_) async => Left("Network error"));

    // Act
    await notifier.fetchActivities();

    // Assert
    expect(notifier.state, isA<AsyncError>());
    expect((notifier.state as AsyncError).error, "Network error");
  });
}
