import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';
import '../../models/productsList/accListModel.dart';

class AccListRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<AccListmodel?> getUserDetails(
    ) async {
    try {
     dynamic response = await _apiService.getResponse(
          ApiEndPoints().userData);
          // TODO: List Handling
      final jsonData = AccListmodel.fromJson(response[0]);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}
