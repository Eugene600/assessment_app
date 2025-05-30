import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:solutech_technical_assessment_app/customers/models/customer.dart';

import '../../utils/utils.dart';

class CustomerService {
  final String _baseUrl = "${Constants.baseUrl}/customers";
  final Map<String, String> _headers = Constants.headers;

  Future<Either<String, List<Customer>>> getCustomers() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final customers = data.map((e) => Customer.fromJson(e)).toList();
        return Right(customers);
      } else {
        return Left('Failed to fetch customers: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error fetching customers: $e');
    }
  }

  Future<Either<String, Customer>> getCustomerById(int id) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?id=eq.$id"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data as List;

        if (list.isEmpty) return Left("Customer not found");
        return Right(Customer.fromJson(list.first));
      } else {
        return Left('Failed to fetch customer: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error fetching customer: $e');
    }
  }

  Future<Either<String, Customer>> postCustomer(Customer customer) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: jsonEncode(customer.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final json = data is List ? data.first : data;
        return Right(Customer.fromJson(json));
      } else {
        return Left('Failed to create customer: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error creating customer: $e');
    }
  }

  Future<Either<String, Customer>> updateCustomer(Customer customer) async {
    try {
      final response = await http.patch(
        Uri.parse("$_baseUrl?id=eq.${customer.id}"),
        headers: _headers,
        body: jsonEncode(customer.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final json = data is List ? data.first : data;
        return Right(Customer.fromJson(json));
      } else {
        return Left('Failed to update customer: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error updating customer: $e');
    }
  }

  Future<Either<String, String>> deleteCustomer(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl?id=eq.$id"),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Right("Customer deleted successfully.");
      } else {
        return Left("Failed to delete customer: ${response.statusCode}");
      }
    } catch (e) {
      return Left('Error deleting customer: $e');
    }
  }
}
