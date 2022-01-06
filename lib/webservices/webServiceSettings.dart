class WebServiceSettings {
  static Map<String, String> getDefaultHeaders() {
    var headers = <String, String>{
      'Content-Type': 'application/json'
    };
    return headers;
  }
}
