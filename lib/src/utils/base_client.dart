import 'package:http/http.dart' as http;

class BaseClient {
  final String baseUrl;
  final String apiKey;
  final String accessToken;

  BaseClient._privateConstructor(
      {required this.baseUrl, required this.apiKey, required this.accessToken});

  static final BaseClient _instance = BaseClient._privateConstructor(
    baseUrl: 'https://api.themoviedb.org/3/movie',
    apiKey: '48367798bdeb3dcc8c642fce3731dd8d',
    accessToken:
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ODM2Nzc5OGJkZWIzZGNjOGM2NDJmY2UzNzMxZGQ4ZCIsInN1YiI6IjY1NDJjNzRmMWFjMjkyMDBjNDk0ZDRlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._-lYeWIQSJ2yZLiQI41c4pHZVW5NsXUBb_ImowJzzgU',
  );

  factory BaseClient() {
    return _instance;
  }

  Future<http.Response> get(String endpoint) async {
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint?api_key=$apiKey'));
    return response;
  }
}
