import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/resources/paginated_result.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';

import '../entities/community_article_entity.dart';
import '../repository/community_article_repository.dart';
import 'community_article_params.dart';

class GetCommunityArticlesUseCase
    implements
        UseCase<
          DataState<PaginatedResult<CommunityArticleEntity>>,
          CommunityArticleParams
        > {
  final CommunityArticleRepository _repository;

  GetCommunityArticlesUseCase(this._repository);

  @override
  Future<DataState<PaginatedResult<CommunityArticleEntity>>> call({
    CommunityArticleParams params = const CommunityArticleParams(),
  }) => _repository.getCommunityArticles(params: params);
}
