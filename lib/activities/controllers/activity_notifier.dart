import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../activities.dart';


class ActivityNotifier extends StateNotifier<AsyncValue<List<Activity>>> {
  final ActivityRepository _repository;

  ActivityNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> fetchActivities() async {
    state = const AsyncValue.loading();

    final result = await _repository.getActivities();

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (activities) => state = AsyncValue.data(activities),
    );
  }
}
