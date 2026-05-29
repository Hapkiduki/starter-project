import 'package:news_app_clean_architecture/core/usecase/usecase.dart';

import '../entities/bookmark_entity.dart';
import '../repository/bookmark_repository.dart';

class GetBookmarksUseCase implements UseCase<List<BookmarkEntity>, void> {
  final BookmarkRepository _bookmarkRepository;

  const GetBookmarksUseCase(this._bookmarkRepository);

  @override
  Future<List<BookmarkEntity>> call({void params}) =>
      _bookmarkRepository.getBookmarks();
}
