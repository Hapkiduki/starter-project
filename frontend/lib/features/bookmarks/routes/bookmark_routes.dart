import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../presentation/bloc/bookmark_bloc.dart';
import '../presentation/bloc/bookmark_event.dart';
import '../presentation/pages/saved_articles_screen.dart';

/// Path constants and route configuration for the bookmarks feature.
abstract final class BookmarkRoutes {
  BookmarkRoutes._();

  // ══════════════════════════════════════════════════════════════════
  // Path Constants
  // ══════════════════════════════════════════════════════════════════

  static const String bookmarks = '/bookmarks';

  // ══════════════════════════════════════════════════════════════════
  // Route Configuration
  // ══════════════════════════════════════════════════════════════════

  /// Routes for the bookmarks shell branch.
  ///
  /// Includes the root bookmarks screen and a tab-aware article detail
  /// sub-route so that back navigation returns to the bookmarks tab.
  static List<RouteBase> getBranchRoutes({
    required GetIt serviceLocator,
    List<RouteBase> subRoutes = const [],
  }) {
    return [
      GoRoute(
        path: bookmarks,
        name: 'bookmarks',
        builder: (_, _) => BlocProvider(
          create: (_) =>
              serviceLocator<BookmarkBloc>()..add(const GetBookmarksEvent()),
          child: const SavedArticlesScreen(),
        ),
        routes: subRoutes,
      ),
    ];
  }
}

// ══════════════════════════════════════════════════════════════════
// Navigation Extensions
// ══════════════════════════════════════════════════════════════════

/// Extension for type-safe navigation to bookmark screens.
extension BookmarkNavigation on BuildContext {
  void goToBookmarks() => go(BookmarkRoutes.bookmarks);
}
