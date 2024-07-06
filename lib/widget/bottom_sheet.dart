import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pocket_swap_fisi/domain/entities/transaction_pending_by_student_code.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../generated/l10n.dart';
import '../domain/entities/user.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import 'drop_down_menu.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCustomBottomSheet(BuildContext context, Position position, User user,
    TransactionPendingByStudentCode transactionPending) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return TransactionForm(
          position: position,
          user: user,
          transactionPending: transactionPending);
    },
  );
}

class TransactionForm extends StatefulWidget {
  final Position position;
  final User user;
  final TransactionPendingByStudentCode transactionPending;

  const TransactionForm(
      {super.key,
      required this.position,
      required this.user,
      required this.transactionPending});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  int selectedValue = 1;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: '0.0');
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    // Remove any non-digit characters
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Ensure the value is not empty and does not start with leading zeros
    if (cleanedValue.isEmpty) {
      cleanedValue = '0';
    } else {
      cleanedValue = cleanedValue.replaceFirst(RegExp(r'^0+'), '');
      if (cleanedValue.isEmpty) {
        cleanedValue = '0';
      }
    }

    // Convert the string to a double
    double newValue = double.parse(cleanedValue) / 10;

    // Ensure the value does not exceed 200.0
    if (newValue > 200.0) {
      newValue = 200.0;
    }

    // Format the value with one decimal place
    String formattedValue = newValue.toStringAsFixed(1);

    // Update the text field value
    setState(() {
      amountController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.fromPosition(
            TextPosition(offset: formattedValue.length)),
      );
    });
  }

  void _submitTransaction() async {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loadUser();
    final user = authProvider.user;

    if (user != null) {
      var register = await transactionProvider.createTransaction(
        user.studentCode ?? '',
        double.parse(amountController.text),
        selectedValue,
        widget.position.latitude,
        widget.position.longitude,
      );

      if (register == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Registro de solicitud de cash exitosa')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Center(
        child: widget.transactionPending.amount != 0
            ? _BuildPendingTransacction(widget.transactionPending)
            : _buildForm(widget.user),
      ),
    );
  }

  Widget _buildForm(User user) {
    return Center(
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              user.userPhoto,
              width: 84,
              height: 84,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user.firstName,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(user.major ?? ''),
          Text(user.studentCode ?? ''),
          const SizedBox(height: 40),
          const Text(
            'PEN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          CurrencyTextField(
            controller: amountController,
            onChanged: _onAmountChanged,
          ),
          const SizedBox(height: 20),
          DropdownMenuExample(
            list: [S.current.DigitalToCash, S.current.CashToDigital],
            onItemSelected: (index) {
              setState(() {
                selectedValue = index + 1;
              });
            },
          ),
          const SizedBox(height: 40),
          BaseElevatedButton(
            text: S.current.PublishRequestCash,
            onPressed: () {
              if (double.parse(amountController.text) != 0.0) {
                _submitTransaction();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('El monto no puede ser 0')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _BuildPendingTransacction(
      TransactionPendingByStudentCode transactionPendingByStudentCode) {
    return Center(
      child: Column(
        children: <Widget>[
          const RegularText(
            text: 'Tienes una transacción pendiente',
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            fontSize: 20.0,
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              const RegularText(
                text: 'PEN',
                fontWeight: FontWeight.bold,
              ),
              Text(
                transactionPendingByStudentCode.amount.toString(),
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(transactionPendingByStudentCode.operationType == 1
                  ? S.current.DigitalToCash
                  : S.current.CashToDigital),
            ],
          ),
          const SizedBox(height: 20),
          RegularText(
            text: '¿Deseas cancelar la transacción?',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          const SizedBox(height: 20),
          BaseElevatedButton(
              text: 'Aceptar',
              onPressed: () async {
                final transactionProvider =
                    Provider.of<TransactionProvider>(context, listen: false);

                int? response =
                    await transactionProvider.updateStatusTransaction(
                        widget.transactionPending.id,
                        widget.user.studentCode ?? '',
                        4);
                if (response == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Transacción cancelada exitosamente')),
                  );
                  Navigator.pop(context);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Error')));
                }

              }),
        ],
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Center(
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Container(
              width: 64,
              height: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
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
    );
  }
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
