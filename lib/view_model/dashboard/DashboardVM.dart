import 'package:flutter/cupertino.dart';
import '../../data/remote/response/ApiResponse.dart';
import '../../models/productsList/accListModel.dart';
import '../../repository/dashboard/accListRepo.dart';

class DashBoardVM extends ChangeNotifier {
  final _accListRepo = AccListRepo();

  ApiResponse<AccListmodel> accListMain = ApiResponse.loading();

  Future<void> fetchAccList() async {
    await _accListRepo.getUserDetails()
        .then((value) => _setAccList(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setAccList(ApiResponse.error(error.toString())));
  }

  void _setAccList(ApiResponse<AccListmodel> response) async {
    accListMain =  response;
    notifyListeners();
  }
}
