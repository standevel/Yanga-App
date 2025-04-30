import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:yanga/pages/notfound.page.dart';
import 'routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    QR.settings.notFoundPage =
        QRoute(path: '/404', builder: () => const NotFoundPage());

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Yanga Learning',
      routeInformationParser: const QRouteInformationParser(),
      routerDelegate: QRouterDelegate(AppRoutes.routes),
    );
  }
}
