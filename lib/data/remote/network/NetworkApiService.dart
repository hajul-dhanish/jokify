import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../utils/global.dart';
import '../AppException.dart';
import 'BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, dynamic> requestData) async {
    dynamic responseJson;
    var encode = jsonEncode(requestData);
    var productsListURL = baseUrl + url;
    print('URL: --- $productsListURL and Request $encode');
    try {
      final response =
          await post(Uri.parse(productsListURL), body: encode, headers: {
        'Content-Type': 'application/json',
        "Accept": "0921db235438905bcea06a304ee49597:$globalAuthToken",
      });
      /*if (response.statusCode == 401 ||
          response.statusCode == 400 ||
          response.statusCode == 403) {
        var data = {"ID": "0921db235438905bcea06a304ee49597"};
        await tokenPostReponse(ApiEndPoints().getToken, data).then((value) {
          var json = jsonDecode(value['Result'][0]);
          globalAuthToken = json[0]['hashvalue'];
          postResponse(url, requestData);
        });
      } else {*/
      responseJson = returnResponse(response);
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future tokenPostReponse(String url, Map<String, dynamic> requestData) async {
    dynamic responseJson;
    var encode = jsonEncode(requestData);
    var productsListURL = baseUrl + url;
    print('URL: --- $productsListURL and Request $encode');
    try {
      final response =
          await post(Uri.parse(productsListURL), body: encode, headers: {
        'Content-Type': 'application/json',
        "Accept": "0921db235438905bcea06a304ee49597:null",
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
