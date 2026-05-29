import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/add_bookmark.dart';
import '../../domain/usecases/bookmark_params.dart';
import '../../domain/usecases/get_bookmarks.dart';
import '../../domain/usecases/remove_bookmark.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

@injectable
final class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final WatchBookmarksUseCase _watchBookmarks;
  final AddBookmarkUseCase _addBookmark;
  final RemoveBookmarkUseCase _removeBookmark;

  BookmarkBloc(this._watchBookmarks, this._addBookmark, this._removeBookmark)
    : super(const BookmarksLoading()) {
    on<GetBookmarksEvent>(_onGetBookmarksEvent);
    on<AddBookmarkEvent>(_onAddBookmarkEvent);
    on<RemoveBookmarkEvent>(_onRemoveBookmarkEvent);
  }

  Future<void> _onGetBookmarksEvent(
    GetBookmarksEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    await emit.forEach(
      _watchBookmarks(),
      onData: (bookmarks) => BookmarksDone(bookmarks),
    );
  }

  Future<void> _onAddBookmarkEvent(
    AddBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    await _addBookmark(params: BookmarkParams(bookmark: event.bookmark));
  }

  Future<void> _onRemoveBookmarkEvent(
    RemoveBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    await _removeBookmark(
      params: BookmarkIdentifierParams(
        sourceId: event.sourceId,
        source: event.source,
      ),
    );
  }
}
