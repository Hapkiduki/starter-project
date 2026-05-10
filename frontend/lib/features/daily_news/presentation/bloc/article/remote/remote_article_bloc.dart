import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/article_params.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase)
    : super(const RemoteArticlesLoading()) {
    on<GetArticles>(_onGetArticles);
    on<LoadMoreArticles>(_onLoadMoreArticles);
  }

  /// Handles the initial load of articles (page 1).
  Future<void> _onGetArticles(
    GetArticles event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(const RemoteArticlesLoading());

    final dataState = await _getArticleUseCase(
      params: const ArticleParams(page: 1),
    );

    switch (dataState) {
      case DataSuccess<dynamic>():
        emit(
          RemoteArticlesDone(
            dataState.data!.articles,
            currentPage: dataState.data!.page,
            hasMore: dataState.data!.hasMore,
            isLoadingMore: false,
          ),
        );
      case DataFailed<dynamic>():
        emit(RemoteArticlesError(dataState.error!));
    }
  }

  /// Handles loading the next page of articles (infinite scroll).
  Future<void> _onLoadMoreArticles(
    LoadMoreArticles event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    final currentState = state;

    // Only proceed if we have a successful state with more pages available
    if (currentState is! RemoteArticlesDone ||
        !currentState.hasMore ||
        currentState.isLoadingMore) {
      return;
    }

    // Emit loading state while fetching next page
    emit(
      RemoteArticlesDone(
        currentState.articles!,
        currentPage: currentState.currentPage,
        hasMore: currentState.hasMore,
        isLoadingMore: true,
      ),
    );

    final nextPage = currentState.currentPage + 1;
    final dataState = await _getArticleUseCase(
      params: ArticleParams(page: nextPage),
    );

    switch (dataState) {
      case DataSuccess<dynamic>():
        // Append new articles to existing list
        final allArticles = [
          ...?currentState.articles,
          ...dataState.data!.articles,
        ];
        emit(
          RemoteArticlesDone(
            allArticles,
            currentPage: nextPage,
            hasMore: dataState.data!.hasMore,
            isLoadingMore: false,
          ),
        );
      case DataFailed<dynamic>():
        // Return to previous state on error, but keep articles
        emit(
          RemoteArticlesDone(
            currentState.articles!,
            currentPage: currentState.currentPage,
            hasMore: currentState.hasMore,
            isLoadingMore: false,
          ),
        );
    }
  }
}
