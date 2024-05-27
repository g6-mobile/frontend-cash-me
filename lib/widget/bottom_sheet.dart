import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drop_down_menu.dart';

void showCustomBottomSheet(BuildContext context) {
  TextEditingController _controller = TextEditingController(text: null);

  const List<String> list = <String>['Digital a efectivo', 'Efectivo a digital'];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Permite controlar la altura del BottomSheet
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height - 60, // Altura del BottomSheet
        width: MediaQuery.of(context).size.width,
        padding:  const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 90,
                height: 7,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset('assets/images/img_profile_user.png', fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                'Diego Chavala',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Ing. de Software'),
              Text("20200097"),
              SizedBox(height: 40),
              RegularText(
                text: 'PEN',
                fontWeight: FontWeight.bold,
              ),
              TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                  decoration: InputDecoration(
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
              DropdownMenuExample(list: list,),
              const SizedBox(height: 40),
              BaseElevatedButton(text: 'Publicar', onPressed: () {}),
              // Agrega más widgets aquí según tus necesidades
            ],
          ),
        ),
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
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            _isSwitched ? 'assets/images/eeuu_english.png' : 'assets/images/peru_spanish.png',
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