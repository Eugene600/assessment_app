import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:solutech_technical_assessment_app/activities/models/activity.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class ActivityService {
  final String _baseUrl = "${Constants.baseUrl}/activities";
  final Map<String, String> _headers = Constants.headers;

  Future<Either<String, List<Activity>>> getActivities() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final activities = data.map((e) => Activity.fromJson(e)).toList();
        return Right(activities);
      } else {
        return Left('Failed to fetch activities: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error fetching activities: $e');
    }
  }

  Future<Either<String, Activity>> getActivityById(int id) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?id=eq.$id"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data as List;

        if (list.isEmpty) return Left("Activity not found");
        return Right(Activity.fromJson(list.first));
      } else {
        return Left('Failed to fetch activity: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error fetching activity: $e');
    }
  }

  Future<Either<String, Activity>> postActivity(Activity activity) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: jsonEncode(activity.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Supabase may return a list instead of a single object
        final json = data is List ? data.first : data;
        return Right(Activity.fromJson(json));
      } else {
        return Left('Failed to create activity: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error creating activity: $e');
    }
  }

  Future<Either<String, Activity>> updateActivity(Activity activity) async {
    try {
      final response = await http.patch(
        Uri.parse("$_baseUrl?id=eq.${activity.id}"),
        headers: _headers,
        body: jsonEncode(activity.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final json = data is List ? data.first : data;
        return Right(Activity.fromJson(json));
      } else {
        return Left('Failed to update activity: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error updating activity: $e');
    }
  }

  Future<Either<String, String>> deleteActivity(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl?id=eq.$id"),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Right("Activity deleted successfully.");
      } else {
        return Left("Failed to delete activity: ${response.statusCode}");
      }
    } catch (e) {
      return Left('Error deleting activity: $e');
    }
  }
}
