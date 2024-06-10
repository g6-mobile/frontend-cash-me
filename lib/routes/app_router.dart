import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter implements AutoRouteGuard {  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'accessToken');

    if (token != null || resolver.route.name == LoginRoute.name) {
      resolver.next();
    } else {
      push(LoginRoute(onResult: (result) {
        resolver.next(result!);
        router.removeLast();
      }));
    }
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/', page: HomeRoute.page, children: [
          AutoRoute(path: 'chat', page: ChatRoute.page),
          AutoRoute(path: 'gift-shop', page: GiftShopRoute.page),
          AutoRoute(path: 'maps', page: MapSample.page),
          AutoRoute(path: 'profile', page: ProfileRoute.page),
          AutoRoute(path: 'transaction-history', page: TransactionsList.page),
        ]),
      ];
}
