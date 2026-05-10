import 'package:drift/drift.dart';

import '../../../models/article.dart';
import '../app_database.dart';
import '../tables/article_table.dart';

part 'article_dao.g.dart';

@DriftAccessor(tables: [Articles])
class ArticleDao extends DatabaseAccessor<AppDatabase> with _$ArticleDaoMixin {
  ArticleDao(super.db);

  Future<void> insertArticle(ArticleModel article) {
    return into(articles).insertOnConflictUpdate(
      ArticlesCompanion(
        id: article.id == null ? const Value.absent() : Value(article.id!),
        author: Value(article.author),
        title: Value(article.title),
        description: Value(article.description),
        url: Value(article.url),
        urlToImage: Value(article.urlToImage),
        publishedAt: Value(article.publishedAt),
        content: Value(article.content),
      ),
    );
  }

  Future<void> deleteArticle(ArticleModel article) async {
    if (article.id == null) return;
    await (delete(articles)..where((tbl) => tbl.id.equals(article.id!))).go();
  }

  Future<List<ArticleModel>> getArticles() async {
    final rows = await select(articles).get();
    return rows
        .map(
          (row) => ArticleModel(
            id: row.id,
            author: row.author,
            title: row.title,
            description: row.description,
            url: row.url,
            urlToImage: row.urlToImage,
            publishedAt: row.publishedAt,
            content: row.content,
          ),
        )
        .toList();
  }
}
