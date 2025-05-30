import 'package:either_dart/either.dart';
import 'package:solutech_technical_assessment_app/activities/models/activity.dart';
import 'package:solutech_technical_assessment_app/activities/services/activity_service.dart';

class ActivityRepository {
  final ActivityService _service;

  ActivityRepository(this._service);

  Future<Either<String, List<Activity>>> getActivities() {
    return _service.getActivities();
  }

  Future<Either<String, Activity>> getActivityById(int id) {
    return _service.getActivityById(id);
  }

  Future<Either<String, Activity>> postActivity(Activity activity) {
    return _service.postActivity(activity);
  }

  Future<Either<String, Activity>> updateActivity(Activity activity) {
    return _service.updateActivity(activity);
  }

  Future<Either<String, String>> deleteActivity(int id) {
    return _service.deleteActivity(id);
  }
}
