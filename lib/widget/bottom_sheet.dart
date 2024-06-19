import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import 'drop_down_menu.dart';

void showCustomBottomSheet(BuildContext context, Position position) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  int selectedValue = 0;
  final transactionProvider =
      Provider.of<TransactionProvider>(context, listen: false);
  authProvider.loadUser();
  final user = authProvider.user;
  TextEditingController amountController = TextEditingController(text: null);
  const List<String> list = <String>[
    'Digital a efectivo',
    'Efectivo a digital'
  ];
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: (MediaQuery.of(context).size.height) * 0.8,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Center(
            child: user != null
                ? Column(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child: ClipOval(
                          child:
                              Image.network(user.userPhoto, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.firstName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${user.major}'),
                      Text('${user.studentCode}'),
                      const SizedBox(height: 40),
                      const RegularText(
                        text: 'PEN',
                        fontWeight: FontWeight.bold,
                      ),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 50.0,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.0',
                          hintStyle: TextStyle(
                            fontSize: 50.0,
                          ),
                        ),
                        onChanged: (value) {
                          // Lógica adicional si es necesario cuando el texto cambia
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownMenuExample(
                        list: list,
                        onItemSelected: (index) {
                          selectedValue = index;
                          print(
                              'El usuario seleccionó el índice: $selectedValue');
                        },
                      ),
                      const SizedBox(height: 40),
                      BaseElevatedButton(
                          text: 'Publicar',
                          onPressed: () async {
                            print(
                                'Posicion:${position.latitude} - ${position.longitude}');
                            print(
                                'El usuario seleccionó el índice: $selectedValue');
                            var register = await transactionProvider.createTransaction(
                                '${user.studentCode}',
                                double.parse(amountController.text),
                                selectedValue,
                                position.latitude,
                                position.longitude);
                            print('register Cash request: $register');
                            if(register == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Registro de solicitud de cash exitosa')));
                              Navigator.pop(context);
                            }
                          }),
                      // Agrega más widgets aquí según tus necesidades
                    ],
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: ClipOval(
                            child: Container(
                              width: 54,
                              height: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 210,
                              height: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 210,
                              height: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
      );
    },
  );
}

class SwitchBottomSheet extends StatefulWidget {
  @override
  _SwitchBottomSheetState createState() => _SwitchBottomSheetState();
}

class _SwitchBottomSheetState extends State<SwitchBottomSheet> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitched = prefs.getBool('switchState') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            _isSwitched
                ? 'assets/images/eeuu_english.png'
                : 'assets/images/peru_spanish.png',
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(_isSwitched ? 'English' : 'Español'),
          SizedBox(height: 2),
          CupertinoSwitch(
            value: _isSwitched,
            activeColor: Color.fromARGB(255, 217, 217, 217),
            onChanged: (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _isSwitched = value;
                prefs.setBool('switchState', value);
              });
            },
          ),
        ],
      ),
    );
  }
}
