import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/resources/paginated_result.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/article_params.dart';

class GetArticleUseCase
    implements
        UseCase<DataState<PaginatedResult<ArticleEntity>>, ArticleParams> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<PaginatedResult<ArticleEntity>>> call({
    ArticleParams params = const ArticleParams(),
  }) {
    return _articleRepository.getNewsArticles(params: params);
  }
}
