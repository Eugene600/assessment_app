import 'package:either_dart/either.dart';
import 'package:solutech_technical_assessment_app/visits/models/visit.dart';
import 'package:solutech_technical_assessment_app/visits/services/visit_service.dart';

class VisitRepository {
  final VisitService _service;

  VisitRepository(this._service);

  Future<Either<String, List<Visit>>> getVisits() {
    return _service.getVisits();
  }

  Future<Either<String, Visit>> getVisitById(int id) {
    return _service.getVisitById(id);
  }

  Future<Either<String, Visit>> postVisit(Visit visit) {
    return _service.postVisit(visit);
  }

  Future<Either<String, Visit>> updateVisit(Visit visit) {
    return _service.updateVisit(visit);
  }

  Future<Either<String, String>> deleteVisit(int id) {
    return _service.deleteVisit(id);
  }
}
