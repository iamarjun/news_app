import 'package:dio/dio.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/source_response.dart';
import 'package:news_app/service/network/rest_client.dart';

class ApiService {
  static final String _apiKey = '84a072f692a848689b11ff35496cddcc';

  Dio _dio;
  RestClient _client;

  ApiService() {
    _dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options) {
            options.headers.addAll(
              {
                'X-Api-Key': _apiKey,
              },
            );
          },
        ),
      );

    _client = RestClient(_dio);
  }

  Future<NewsResponse> getNewsFromCountry(
      String country, String query, int page) async {
    NewsResponse newsResponse;

    try {
      final response = await _client.getNewsFromCountry(country, query, page);
      newsResponse = response;
    } catch (e) {
      print(e);
    }

    return newsResponse;
  }
  
  Future<SourceResponse> getSource() async {
    SourceResponse sourceResponse;

    try {
      final response = await _client.getSources();
      sourceResponse = response;
    } catch (e) {
      print(e);
    }

    return sourceResponse;
  }
}
