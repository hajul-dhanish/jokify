import '../../Env/base_config.dart';

abstract class BaseApiService {
  final String baseUrl = Environment().config!.apiHost;

  Future<dynamic> getResponse(String url);
  Future<dynamic> postResponse(String url, Map<String, dynamic> requestData);
}
