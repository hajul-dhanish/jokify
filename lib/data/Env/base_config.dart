abstract class BaseConfig {
  String get apiHost;
  String get imgBaseUrl;
  bool get useHttps;
  bool get trackEvents;
  bool get reportErrors;
}

class DevConfig implements BaseConfig {
  String get apiHost =>
      "https://uatq2s.shriramvalue.me/UATQ2SService/DealerStoreService.svc/";

  bool get reportErrors => false;

  bool get trackEvents => false;

  bool get useHttps => false;

  String get imgBaseUrl => 'https://uatq2s.shriramvalue.me/UATQ2SAdmin/CommonFunctions/OAS_ImageDisplay.ashx?Path=';
}

class StagingConfig implements BaseConfig {
  String get apiHost =>
      "https://uatq2s.shriramvalue.me/UATQ2SService/DealerStoreService.svc/";

  bool get reportErrors => true;

  bool get trackEvents => false;

  bool get useHttps => true;

  String get imgBaseUrl => 'https://uatq2s.shriramvalue.me/UATQ2SAdmin/CommonFunctions/OAS_ImageDisplay.ashx?Path=';
}

class ProdConfig implements BaseConfig {
  String get apiHost =>
      "https://uatq2s.shriramvalue.me/UATQ2SService/DealerStoreService.svc/";

  bool get reportErrors => true;

  bool get trackEvents => true;

  bool get useHttps => true;

  String get imgBaseUrl => 'https://uatq2s.shriramvalue.me/UATQ2SAdmin/CommonFunctions/OAS_ImageDisplay.ashx?Path=';
}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseConfig? config;
  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.STAGING:
        return StagingConfig();
      default:
        return DevConfig();
    }
  }
}
