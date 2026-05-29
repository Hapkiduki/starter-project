import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';

import '../entities/community_article_entity.dart';
import '../repository/community_article_repository.dart';
import 'community_article_params.dart';

class GetCommunityArticleByIdUseCase
    implements
        UseCase<DataState<CommunityArticleEntity>, GetArticleByIdParams> {
  final CommunityArticleRepository _repository;

  GetCommunityArticleByIdUseCase(this._repository);

  @override
  Future<DataState<CommunityArticleEntity>> call({
    GetArticleByIdParams? params,
  }) => _repository.getCommunityArticleById(id: params!.id);
}
