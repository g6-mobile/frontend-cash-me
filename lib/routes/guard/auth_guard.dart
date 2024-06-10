import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'accessToken');

    if (token != null) {
      resolver.next(true);
    } else {
      router.push(LoginRoute(onResult: (result) async {
        if (result == true) {
          resolver.next(true);
          router.removeLast();
        }
      }));
      // resolver.redirect(LoginRoute(
      //   onResult: (success) {
      //     resolver.next(success!);
      //   },
      // ));
    }
  }
}
