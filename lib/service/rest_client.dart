import 'package:dio/dio.dart';
import 'package:news_app/models/news_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // @GET("sources")
  //    fun getSources(): SourceResponse

  @GET("top-headlines")
  Future<NewsResponse> getNewsFromCountry(
    @Query("country") String country,
    @Query("q") String q,
    @Query("page") int page,
  );

  @GET("top-headlines")
  Future<NewsResponse> getNewsFromSources(
    @Query("sources") String sources,
    @Query("q") String query,
    @Query("page") int page,
  );
}
