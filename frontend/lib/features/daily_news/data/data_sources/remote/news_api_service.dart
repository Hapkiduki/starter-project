import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/models/common.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';

import 'news_api_client.dart';

@injectable
class NewsApiService {
  final NewsApiClient _client;

  const NewsApiService(this._client);

  Cancellable<List<ArticleModel>> getNewsArticles({
    String? apiKey,
    String? country,
    String? category,
  }) {
    final cancelToken = CancelToken();
    final call = _client.getNewsArticles(
      apiKey: apiKey,
      country: country,
      category: category,
      cancelToken: cancelToken,
    );
    return Cancellable(call, cancelToken);
  }
}
