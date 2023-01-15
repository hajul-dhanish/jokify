import 'package:flutter/cupertino.dart';
import '../../data/remote/response/ApiResponse.dart';
import '../../models/productsList/ProductsModel.dart';
import '../../repository/dashboard/TopCategoryRepo.dart';
import '../../utils/global.dart';

class DashBoardVM extends ChangeNotifier {
  final _topCategoryRepo = TopCategoryRepo();

  ApiResponse<ProductModel> topCategoryMain = ApiResponse.loading();

  Future<void> fetchTopCategory() async {
    var data = {"Action": "GetAllData", "Pincode": "600001"};
    await _topCategoryRepo
        .getTopCategoryList(data, globalAuthToken)
        .then((value) => _setTopCategory(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setTopCategory(ApiResponse.error(error.toString())));
  }

  void _setTopCategory(ApiResponse<ProductModel> response) async {
    topCategoryMain = await response;
    notifyListeners();
  }
}
