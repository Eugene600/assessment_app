import 'package:either_dart/either.dart';
import 'package:solutech_technical_assessment_app/customers/models/customer.dart';
import 'package:solutech_technical_assessment_app/customers/services/customer_service.dart';

class CustomerRepository {
  final CustomerService _service;

  CustomerRepository(this._service);

  Future<Either<String, List<Customer>>> getCustomers() {
    return _service.getCustomers();
  }

  Future<Either<String, Customer>> getCustomerById(int id) {
    return _service.getCustomerById(id);
  }

  Future<Either<String, Customer>> postCustomer(Customer customer) {
    return _service.postCustomer(customer);
  }

  Future<Either<String, Customer>> updateCustomer(Customer customer) {
    return _service.updateCustomer(customer);
  }

  Future<Either<String, String>> deleteCustomer(int id) {
    return _service.deleteCustomer(id);
  }
}
