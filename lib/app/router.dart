import 'package:go_router/go_router.dart';
import 'package:mini_check/pages/home/home.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => HomeScreen())],
);
