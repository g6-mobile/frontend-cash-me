import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';

import '../../dummy_data.dart';
import '../../generated/l10n.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
        routes: [
          TransactionsList(transactions: transactions),
          const GiftShopRoute(),
          const MapSample(),
          const ChatRoute(),
          const ProfileRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return AnnotatedRegion(
              value: SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark),
              child: Scaffold(
                body: child,
                bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (value) {
                    tabsRouter.setActiveIndex(value);
                  },
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: const Icon(Icons.restore),
                      icon: const Icon(Icons.restore_outlined),
                      label: S.current.NavBarBottomTransaction,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: const Icon(Icons.card_giftcard),
                      icon: const Icon(Icons.card_giftcard_outlined),
                      label: S.current.NavBarBottomGiftShop,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: const Icon(Icons.home),
                      icon: const Icon(Icons.home_outlined),
                      label: S.current.NavBarBottomHome,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: const Icon(Icons.message),
                      icon: const Icon(Icons.message_outlined),
                      label: S.current.NavBarBottomMessage,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: const Icon(Icons.person_2),
                      icon: const Icon(Icons.person_2_outlined),
                      label: S.current.NavBarBottomProfile,
                    ),
                  ],
                ),
              ));
        });
  }
}
