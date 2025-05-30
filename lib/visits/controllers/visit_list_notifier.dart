import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../visits.dart';

class VisitListNotifier extends StateNotifier<AsyncValue<List<Visit>>> {
  final VisitRepository _repo;

  VisitListNotifier(this._repo) : super(const AsyncValue.loading());

  Future<void> getVisits() async {
    state = const AsyncValue.loading();
    final result = await _repo.getVisits();

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (visits) => state = AsyncValue.data(visits),
    );
  }
}
