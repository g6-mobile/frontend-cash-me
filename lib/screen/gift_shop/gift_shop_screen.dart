import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GiftShopScreen extends StatefulWidget{
  const GiftShopScreen({Key? key}) : super(key: key);

  @override
  _GifyShopScreenState createState() => _GifyShopScreenState();
}

class _GifyShopScreenState extends State <GiftShopScreen>{
  @override
  Widget build(BuildContext){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Gift Shop Screen'
            )
          ],
        ),
      ),
    );
  }
}