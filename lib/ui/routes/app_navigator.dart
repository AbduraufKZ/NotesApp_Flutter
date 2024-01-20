import 'package:go_router/go_router.dart';
import 'package:lesson3/ui/pages/add_note_page.dart';
import 'package:lesson3/ui/pages/change_note_page.dart';
import 'package:lesson3/ui/pages/home_page.dart';
import 'package:lesson3/ui/pages/search_note_page.dart';
import 'package:lesson3/ui/routes/app_routes.dart';

class AppNavigator {
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.addNotes,
        builder: (context, state) => const AddNotePage(),
      ),
      GoRoute(
        path: AppRoutes.changeNotes,
        builder: (context, state) => const ChangeNotePage(),
      ),
      GoRoute(
        path: AppRoutes.searchNotes,
        builder: (context, state) => const SearchNotePage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
