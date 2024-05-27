import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_swap_fisi/screen/maps/maps_screen.dart';
import 'package:pocket_swap_fisi/screen/passwords/forgot_password_screen.dart';
import 'package:pocket_swap_fisi/screen/profile/profile_screen.dart';
import '../../generated/l10n.dart';
import 'package:pocket_swap_fisi/dummy_data.dart';

import '../history/transaction_history_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  int currentPageIndex = 2;
  @override
  Widget build(BuildContext context){
    return AnnotatedRegion(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
          
        ),
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
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.restore),
                  icon: Icon(Icons.restore_outlined),
                  label: 'Transactions',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.card_giftcard),
                  icon: Icon(Icons.card_giftcard_outlined),
                  label: 'Gift Shop',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.message),
                  icon: Icon(Icons.message_outlined),
                  label: 'Messages',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.person_2),
                  icon: Icon(Icons.person_2_outlined),
                  label: 'Profile',
                ),
              ],
            ),
            body: <Widget>[
                // Home page
                Center(
                  child: TransactionsList(transactions: transactions),
                ),

                /// Notifications page
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.notifications_sharp),
                          title: Text('Notification 1'),
                          subtitle: Text('This is a notification'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.notifications_sharp),
                          title: Text('Notification 2'),
                          subtitle: Text('This is a notification'),
                        ),
                      ),
                    ],
                  ),
                ),

                //Map Screen
                Center(
                    child: MapSample()
                ),

                Card(
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox.expand(
                    child: Center(
                      child: MapSample(),
                    ),
                  ),
                ),

                /// ProfileScreen
                Center(
                  child: ProfileScreen(),
                ),
              ][currentPageIndex],
            )
    );
  }
}