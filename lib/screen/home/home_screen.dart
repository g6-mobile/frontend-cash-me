import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_swap_fisi/screen/gift_shop/gift_shop_screen.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:pocket_swap_fisi/screen/chat/chat_screen.dart';
import 'package:pocket_swap_fisi/screen/maps/maps_screen.dart';
import 'package:pocket_swap_fisi/screen/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../dummy_data.dart';
import '../../generated/l10n.dart';
import '../history/transaction_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 2;
  int randomNumber = Random().nextInt(10);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              backgroundColor: Theme.of(context).colorScheme.background,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              indicatorColor: Color(0xFFFFE7E7),
              selectedIndex: currentPageIndex,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: const Icon(Icons.restore),
                  icon: const Icon(Icons.restore_outlined),
                  label: S.current.NavBarBottomTransaction,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(Icons.card_giftcard),
                  icon: const Icon(Icons.card_giftcard_outlined),
                  label: S.current.NavBarBottomGiftShop,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(Icons.home),
                  icon: const Icon(Icons.home_outlined),
                  label: S.current.NavBarBottomHome,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(Icons.message),
                  icon: const Icon(Icons.message_outlined),
                  label: S.current.NavBarBottomMessage,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(Icons.person_2),
                  icon: const Icon(Icons.person_2_outlined),
                  label: S.current.NavBarBottomProfile,
                ),
              ],
            ),
            body: <Widget>[
                // Home page
                TransactionsList(transactions: transactions),

                // Gift Shop Screen
                const GiftShopScreen(),

                //Map Screen
                const MapSample(),

                Card(
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox.expand(
                    child: Center(
                      child: MapSample(),
                    ),
                  ),
                ),

                // ProfileScreen
                const ProfileScreen(),
              ][currentPageIndex],
            )
    );
  }
}