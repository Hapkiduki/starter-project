import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_client.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';

import 'news_api_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NewsApiClient>()])
void main() {
  group('NewsApiService', () {
    late MockNewsApiClient client;
    late NewsApiService service;

    setUp(() {
      client = MockNewsApiClient();
      service = NewsApiService(client);
    });

    test('forwards request parameters and returns client articles', () async {
      const expectedArticles = [ArticleModel(title: 'Top headline')];
      when(
        client.getNewsArticles(
          apiKey: anyNamed('apiKey'),
          country: anyNamed('country'),
          category: anyNamed('category'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => expectedArticles);

      final cancellable = service.getNewsArticles(
        apiKey: 'api-key',
        country: 'us',
        category: 'business',
      );

      await expectLater(cancellable.call, completion(expectedArticles));
      final verification = verify(
        client.getNewsArticles(
          apiKey: 'api-key',
          country: 'us',
          category: 'business',
          cancelToken: captureAnyNamed('cancelToken'),
        ),
      );
      final capturedToken = verification.captured.single as CancelToken;

      expect(capturedToken, same(cancellable.token));
      expect(cancellable.token.isCancelled, isFalse);
    });

    test('cancels the same token passed to the client', () async {
      final completer = Completer<List<ArticleModel>>();
      when(
        client.getNewsArticles(
          apiKey: anyNamed('apiKey'),
          country: anyNamed('country'),
          category: anyNamed('category'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) => completer.future);

      final cancellable = service.getNewsArticles();
      final verification = verify(
        client.getNewsArticles(
          apiKey: null,
          country: null,
          category: null,
          cancelToken: captureAnyNamed('cancelToken'),
        ),
      );
      final capturedToken = verification.captured.single as CancelToken;

      expect(capturedToken.isCancelled, isFalse);

      cancellable.cancel();

      expect(capturedToken.isCancelled, isTrue);

      completer.complete(const <ArticleModel>[]);
      await expectLater(cancellable.call, completion(isEmpty));
    });
  });
}
