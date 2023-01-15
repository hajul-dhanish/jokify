import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';
import '../../models/productsList/ProductsModel.dart';

class TopCategoryRepo {
  BaseApiService _apiService = NetworkApiService();

  Future<ProductModel?> getTopCategoryList(
      Map<String, dynamic> requestData, String authToken) async {
    try {
      dynamic response = await _apiService.postResponse(
          ApiEndPoints().getTopCategory, requestData);
      final jsonData = ProductModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }
}
