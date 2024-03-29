import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../AppException.dart';
import 'BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    debugPrint('URL:get --- ${baseUrl + url}');
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
    debugPrint('URL:post --- ${baseUrl + url} and Request $encode');
    try {
      final response =
          await http.post(Uri.parse(baseUrl + url), body: encode, headers: {
        'Content-Type': 'application/json',
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
