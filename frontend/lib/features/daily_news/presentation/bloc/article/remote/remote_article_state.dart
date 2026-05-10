import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entities/article.dart';

abstract class RemoteArticlesState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioError? error;

  const RemoteArticlesState({this.articles, this.error});

  @override
  List<Object?> get props => [articles, error];
}

/// Loading state for initial article fetch.
class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

/// Success state with articles and pagination metadata.
class RemoteArticlesDone extends RemoteArticlesState {
  /// The current page number (1-based).
  final int currentPage;

  /// Whether more pages are available.
  final bool hasMore;

  /// Whether currently loading more articles (for infinite scroll).
  final bool isLoadingMore;

  const RemoteArticlesDone(
    List<ArticleEntity> articles, {
    this.currentPage = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
  }) : super(articles: articles);

  @override
  List<Object?> get props => [
    articles,
    currentPage,
    hasMore,
    isLoadingMore,
    error,
  ];
}

/// Error state when article fetch fails.
class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioError error) : super(error: error);
}
