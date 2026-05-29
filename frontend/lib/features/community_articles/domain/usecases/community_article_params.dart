import 'dart:io';

/// Parameters for [GetCommunityArticlesUseCase].
///
/// Uses cursor-based pagination suited for Firestore.
/// Pass [lastDocumentId] (the ID of the last received article) to get the next page.
/// Omit [lastDocumentId] (or pass null) to fetch the first page.
class CommunityArticleParams {
  final int pageSize;
  final String? lastDocumentId;

  const CommunityArticleParams({this.pageSize = 20, this.lastDocumentId});
}

/// Parameters for [GetCommunityArticleByIdUseCase].
class GetArticleByIdParams {
  final String id;

  const GetArticleByIdParams({required this.id});
}

/// Parameters for [GetUserArticlesUseCase].
class GetUserArticlesParams {
  final String userId;

  const GetUserArticlesParams({required this.userId});
}

/// Parameters for [CreateCommunityArticleUseCase].
class CreateArticleParams {
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final String? description;
  final File? imageFile;
  final String? category;

  const CreateArticleParams({
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    this.description,
    this.imageFile,
    this.category,
  });
}

/// Parameters for [UpdateCommunityArticleUseCase].
///
/// Only non-null fields are updated. Set [removeImage] to true to
/// explicitly delete the current image without replacing it.
class UpdateArticleParams {
  final String id;
  final String? title;
  final String? content;
  final String? description;
  final File? imageFile;
  final bool removeImage;
  final String? category;

  const UpdateArticleParams({
    required this.id,
    this.title,
    this.content,
    this.description,
    this.imageFile,
    this.removeImage = false,
    this.category,
  });
}

/// Parameters for [DeleteCommunityArticleUseCase].
class DeleteArticleParams {
  final String id;

  const DeleteArticleParams({required this.id});
}
