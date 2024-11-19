import 'package:alert_app/models/alert_model.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/result.dart';

class AlertService {
  final ApiService apiService;

  AlertService({required this.apiService});
  Future<List<Result<AlertModel>>> getAlertsByTopic(String dataSearch) {
    return apiService.getMapping("alerts/history");
  }
}
