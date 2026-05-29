import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';

import '../repository/community_article_repository.dart';
import 'community_article_params.dart';

class DeleteCommunityArticleUseCase
    implements UseCase<DataState<void>, DeleteArticleParams> {
  final CommunityArticleRepository _repository;

  DeleteCommunityArticleUseCase(this._repository);

  @override
  Future<DataState<void>> call({DeleteArticleParams? params}) =>
      _repository.deleteCommunityArticle(id: params!.id);
}
