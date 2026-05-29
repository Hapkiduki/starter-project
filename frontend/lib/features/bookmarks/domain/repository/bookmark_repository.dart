import '../entities/article_source.dart';
import '../entities/bookmark_entity.dart';

abstract class BookmarkRepository {
  Future<List<BookmarkEntity>> getBookmarks();

  Future<void> addBookmark(BookmarkEntity bookmark);

  Future<void> removeBookmark(String sourceId, ArticleSource source);

  Future<bool> isBookmarked(String sourceId, ArticleSource source);
}
