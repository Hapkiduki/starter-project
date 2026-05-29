import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/repository/community_article_repository.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/usecases/create_community_article.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/usecases/delete_community_article.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/usecases/get_community_article_by_id.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/usecases/get_community_articles.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/usecases/get_user_articles.dart';
import 'package:news_app_clean_architecture/features/community_articles/domain/usecases/update_community_article.dart';

@module
abstract class CommunityArticlesModule {
  @lazySingleton
  GetCommunityArticlesUseCase getCommunityArticlesUseCase(
    CommunityArticleRepository repository,
  ) => GetCommunityArticlesUseCase(repository);

  @lazySingleton
  GetCommunityArticleByIdUseCase getCommunityArticleByIdUseCase(
    CommunityArticleRepository repository,
  ) => GetCommunityArticleByIdUseCase(repository);

  @lazySingleton
  GetUserArticlesUseCase getUserArticlesUseCase(
    CommunityArticleRepository repository,
  ) => GetUserArticlesUseCase(repository);

  @lazySingleton
  CreateCommunityArticleUseCase createCommunityArticleUseCase(
    CommunityArticleRepository repository,
  ) => CreateCommunityArticleUseCase(repository);

  @lazySingleton
  UpdateCommunityArticleUseCase updateCommunityArticleUseCase(
    CommunityArticleRepository repository,
  ) => UpdateCommunityArticleUseCase(repository);

  @lazySingleton
  DeleteCommunityArticleUseCase deleteCommunityArticleUseCase(
    CommunityArticleRepository repository,
  ) => DeleteCommunityArticleUseCase(repository);
}
