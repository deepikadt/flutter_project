abstract class AppBaseUrl {
  // Development
  static String devBaseUrl = "https://api.producthunt.com/v1";
}

abstract class AppClientKeys {
  static String clientToken = "0YgRI5GSeV5siKN1q5HeNvK7Ip47sCNSR5yEBUU8NNE";
  static String redirectUrl = "https://example.org/";
}

abstract class AppKeys {
  static const String isFollowersList = 'is_followers_list';
}

abstract class AppPreferenceKeys {
  static String accessToken = "accessToken";
  static String timeStamp = "timestamp";
}

abstract class ApiEndPoints {
  static const String addressSearch = "/demoApi";

  // app end points
  static const String generateAccessCode = "/oauth/authorize";
  static const String generateAccessToken = '/oauth/token';
  static const String collections = "/collections";
  static const String product = "/posts";
}

abstract class ApiKeys {
  // HEADER keys
  static const String getMethod = 'GET';
  static const String postMethod = 'POST';
  static const String putMethod = 'PUT';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String formData = 'multipart/form-data';
  static const String authorization = 'Authorization';
  static const String accept = 'Accept';
  static const String apiKey = 'api_key';
  static const String userAgent = 'User-Agent';

  // request keys
  static const String fields = 'fields';
  static const String files = 'files';

  //response keys
  static const String errorNo = 'errorNo';
  static const String message = 'message';
}
