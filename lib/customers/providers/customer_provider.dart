import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../customers.dart';

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final service = CustomerService();
  return CustomerRepository(service);
});


final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, AsyncValue<List<Customer>>>((ref) {
  final repository = ref.read(customerRepositoryProvider);
  return CustomerNotifier(repository);
});