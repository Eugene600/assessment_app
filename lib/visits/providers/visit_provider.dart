import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../visits.dart';

final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  final service = VisitService();
  return VisitRepository(service);
});


final visitListNotifierProvider =
    StateNotifierProvider<VisitListNotifier, AsyncValue<List<Visit>>> ((ref) {
  final repository = ref.read(visitRepositoryProvider);
  return VisitListNotifier(repository);
});

final visitDetailNotifierProvider =
    StateNotifierProvider<VisitDetailNotifier, AsyncValue<Visit?>> ((ref) {
  final repository = ref.read(visitRepositoryProvider);
  return VisitDetailNotifier(repository);
});