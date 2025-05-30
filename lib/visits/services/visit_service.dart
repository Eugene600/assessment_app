import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:solutech_technical_assessment_app/visits/models/visit.dart';

import '../../utils/utils.dart';

class VisitService {
  final String _baseUrl = "${Constants.baseUrl}/visits";
  final Map<String, String> _headers = Constants.headers;

  Future<Either<String, List<Visit>>> getVisits() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

      print("Response Status code: ${response.statusCode}");
      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          final visits = decoded.map((e) => Visit.fromJson(e)).toList();
          return Right(visits);
        } else {
          return Left(
            "Unexpected data format — expected a List but got ${decoded.runtimeType}",
          );
        }
      } else {
        return Left('Failed to fetch visits: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching visits: $e');
      return Left('Error fetching visits: $e');
    }
  }

  Future<Either<String, Visit>> getVisitById(int id) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?id=eq.$id"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data as List;

        if (list.isEmpty) return Left("Visit not found");
        return Right(Visit.fromJson(list.first));
      } else {
        return Left('Failed to fetch visit: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error fetching visit: $e');
    }
  }

  Future<Either<String, Visit>> postVisit(Visit visit) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {..._headers, 'Prefer': 'return=representation'},
        body: jsonEncode(visit.toJson()),
      );

      print("Response: ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Data: $data");
        final json = data is List ? data.first : data;
        return Right(Visit.fromJson(json));
      } else {
        print('Failed to create visit: ${response.statusCode}');
        return Left('Failed to create visit: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating visit: $e');
      return Left('Error creating visit: $e');
    }
  }

  Future<Either<String, Visit>> updateVisit(Visit visit) async {
    try {
      final response = await http.patch(
        Uri.parse("$_baseUrl?id=eq.${visit.id}"),
        headers: _headers,
        body: jsonEncode(visit.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final json = data is List ? data.first : data;
        return Right(Visit.fromJson(json));
      } else {
        return Left('Failed to update visit: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error updating visit: $e');
    }
  }

  Future<Either<String, String>> deleteVisit(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl?id=eq.$id"),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Right("Visit deleted successfully.");
      } else {
        return Left("Failed to delete visit: ${response.statusCode}");
      }
    } catch (e) {
      return Left('Error deleting visit: $e');
    }
  }
}
