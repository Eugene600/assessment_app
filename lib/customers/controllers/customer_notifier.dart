import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_technical_assessment_app/customers/models/customer.dart';
import 'package:solutech_technical_assessment_app/customers/repository/customer_repository.dart';

class CustomerNotifier extends StateNotifier<AsyncValue<List<Customer>>> {
  final CustomerRepository _repository;

  CustomerNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> fetchCustomers() async {
    state = const AsyncValue.loading();

    final result = await _repository.getCustomers();

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (customers) => state = AsyncValue.data(customers),
    );
  }
}
