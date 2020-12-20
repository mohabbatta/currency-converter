class ApiPath {
  static String latest(String key) =>
      'http://data.fixer.io/api/latest?access_key=$key';
  static String flag(String code) =>
      'https://restcountries.eu/rest/v2/currency/$code?fields=flag';
  static String changeBase(String key, String base) =>
      'http://data.fixer.io/api/latest?access_key=$key&base=$base';
}
