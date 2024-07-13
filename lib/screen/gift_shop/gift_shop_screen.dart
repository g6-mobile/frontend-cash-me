import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../generated/l10n.dart'; //S

@RoutePage()
class GiftShopScreen extends StatefulWidget{
  const GiftShopScreen({Key? key}) : super(key: key);

  @override
  _GifyShopScreenState createState() => _GifyShopScreenState();
}

class _GifyShopScreenState extends State <GiftShopScreen>{
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loadUser();
  }

  @override
Widget build(BuildContext context) {
  return Consumer<AuthProvider>(builder: (context, authProvider, child) {
    final user = authProvider.user;
    final lista_regalos = ['Flores','Hot Wheels','Play Doh','Funko','Pelota Mundial 2022','Taza','Cubo Rubik'];
    
    return Scaffold(
      appBar: AppBar(
        title: SubtitleText(
          text: S.current.GiftShop, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/img_profile_user.png',
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('Hola\nDiego'),
                  Spacer(),
                  Text('Tienes: \n1500🪙')
                ],
              ),
            ),

            // Aquí implementa el código para el grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Padding de 20 en todos los lados
                child: GridView.builder(
                  itemCount: 7, // Número de elementos en el grid
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    //print('holamundo ${index+1}');
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4, // Ajusta la proporción según tus necesidades
                            child: Image.asset(
                              'assets/images/regalo_${index+1}.jpg', // Asumiendo que tienes imágenes de placeholder numeradas
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            flex: 1, // Ajusta la proporción según tus necesidades
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white, // O el color que desees para el fondo del texto
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${lista_regalos[index]}',
                                style: TextStyle(color: Colors.black), // Ajusta el estilo de texto según necesites
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  });
}

}