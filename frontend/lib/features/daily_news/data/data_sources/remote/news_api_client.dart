import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

part 'news_api_client.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio) = _NewsApiClient;

  @GET('/top-headlines')
  Future<List<ArticleModel>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
    @CancelRequest() CancelToken? cancelToken,
  });
}
