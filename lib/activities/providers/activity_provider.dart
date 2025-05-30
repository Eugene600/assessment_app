import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../activities.dart';

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  final service = ActivityService();
  return ActivityRepository(service);
});


final activityNotifierProvider =
    StateNotifierProvider<ActivityNotifier, AsyncValue<List<Activity>>>((ref) {
  final repository = ref.read(activityRepositoryProvider);
  return ActivityNotifier(repository);
});