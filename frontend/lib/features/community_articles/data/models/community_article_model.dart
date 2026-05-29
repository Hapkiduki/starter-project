import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/community_article_entity.dart';

/// Data model for a community article, mapping to and from Firestore documents.
class CommunityArticleModel extends CommunityArticleEntity {
  const CommunityArticleModel({
    required super.id,
    required super.authorId,
    required super.authorName,
    required super.title,
    required super.content,
    super.description,
    super.imageUrl,
    super.category,
    required super.publishedAt,
    super.updatedAt,
  });

  /// Creates a [CommunityArticleModel] from a Firestore [DocumentSnapshot].
  factory CommunityArticleModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return CommunityArticleModel(
      id: doc.id,
      authorId: data['authorId'] as String,
      authorName: data['authorName'] as String,
      title: data['title'] as String,
      content: data['content'] as String,
      description: data['description'] as String?,
      imageUrl: data['imageUrl'] as String?,
      category: data['category'] as String?,
      publishedAt: (data['publishedAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Serializes this model to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'content': content,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (category != null) 'category': category,
      'publishedAt': Timestamp.fromDate(publishedAt),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  /// Converts this model to a pure domain [CommunityArticleEntity].
  CommunityArticleEntity toEntity() {
    return CommunityArticleEntity(
      id: id,
      authorId: authorId,
      authorName: authorName,
      title: title,
      content: content,
      description: description,
      imageUrl: imageUrl,
      category: category,
      publishedAt: publishedAt,
      updatedAt: updatedAt,
    );
  }
}
