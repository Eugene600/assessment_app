import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../visits.dart';

class VisitDetailNotifier extends StateNotifier<AsyncValue<Visit?>> {
  final VisitRepository _repo;

  VisitDetailNotifier(this._repo) : super(const AsyncValue.data(null));

  Future<void> getVisitById(int id) async {
    state = const AsyncValue.loading();
    final result = await _repo.getVisitById(id);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (visit) => state = AsyncValue.data(visit),
    );
  }

  Future<Either<String, Visit>> postVisit(Visit visit) async {
    state = const AsyncValue.loading();
    final result = await _repo.postVisit(visit);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (created) => state = AsyncValue.data(created),
    );

    return result;
  }

  Future<void> updateVisit(Visit visit) async {
    state = const AsyncValue.loading();
    final result = await _repo.updateVisit(visit);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (updated) => state = AsyncValue.data(updated),
    );
  }

  Future<void> deleteVisit(int id) async {
    state = const AsyncValue.loading();
    final result = await _repo.deleteVisit(id);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }
}
