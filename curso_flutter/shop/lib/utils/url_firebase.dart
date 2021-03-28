class UrlFirebase {
  static String urlDatabase = '';
  static String urlAuth = '';
  static String apiKey = '';

  static String getUrl(String resource) {
    return '$urlAuth:$resource?key=$apiKey';
  }
}